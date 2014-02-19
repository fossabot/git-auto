#!/bin/bash
# this file is part of git-auto which is released under the mit license.
# go to http://opensource.org/licenses/mit for full details.

#set -o nounset
#set -o errexit

ROOT_RUN=$(pwd)
ROOT_TEST=$(readlink -f "${BASH_SOURCE[0]}" | xargs dirname)
ROOT_HOOKS="${ROOT_TEST}/../hook"
source "${ROOT_TEST}/../../common/lib/swiss.sh/swiss.sh"
export PATH=${PATH}:${ROOT_TEST}/..  # make git auto runnable

main() {
  # test suite which verifies that the init command functions correctly.
  # globals:
  #   none
  # arguments:
  #   none
  # returns:
  #   none
  git_auto_init_installs_hooks
  git_auto_init_initialises_new_repository
  git_auto_init_initialises_existing_repository
  git_auto_init_initialises_existing_repository_with_origin
  git_auto_init_initialises_existing_repository_with_remote
}

git_auto_init_installs_hooks() {
  setup
  git auto init &> /dev/null
  assert "init_main() installs hooks" \
         "ls .git/hooks/ | sed '/.*sample$/d'" \
         "$(ls ${ROOT_HOOKS}/)"
  cleanup
}

git_auto_init_initialises_new_repository() {
  setup
  git auto init &> /dev/null
  assert "init_main() initialise new repository with version" \
         "git describe HEAD" \
         "0.0.0"
  assert "init_main() initialise new repository with branches" \
         "git branch --no-color --contains HEAD" \
         "* master"$'\n'"  release"  # force newline
  cleanup
}

git_auto_init_initialises_existing_repository() {
  setup
  git init &> /dev/null
  git commit --allow-empty --message="this repository exists" &> /dev/null
  git auto init &> /dev/null
  assert "init_main() initialise existing repository with version" \
         "git describe HEAD" \
         "0.0.0"
  assert "init_main() initialise existing repository with branches" \
         "git branch --no-color --contains HEAD" \
         "* master"$'\n'"  release"  # force newline
  cleanup
}

git_auto_init_initialises_existing_repository_with_origin() {
  setup

  # setup origin and local repository.
  mkdir origin.git
  cd origin.git
  git init --bare &> /dev/null
  cd ..
  git clone origin.git local_repository &> /dev/null
  cd local_repository
  git commit --allow-empty --message="this repository exists" &> /dev/null
  git auto init &> /dev/null

  # test local repository
  assert "init_main() initialise existing repository with origin with local version" \
         "git describe HEAD" \
         "0.0.0"
  assert "init_main() initialise existing repository with origin with local branches" \
         "git branch --no-color --contains HEAD" \
         "* master"$'\n'"  release"  # force newline

  # test origin
  cd ../origin.git
  assert "init_main() initialise existing repository with origin with remote version" \
         "git describe HEAD" \
         "0.0.0"
  assert "init_main() initialise existing repository with origin with remote branches" \
         "git branch --no-color --contains HEAD" \
         "* master"$'\n'"  release"  # force newline

  cleanup
}

git_auto_init_initialises_existing_repository_with_remote() {
  setup

  # setup remote and local repository.
  mkdir remote.git
  cd remote.git
  git init --bare &> /dev/null
  cd ..
  git clone remote.git local_repository &> /dev/null
  cd local_repository
  git commit --allow-empty --message="this repository exists" &> /dev/null
  git remote rename origin remote
  git auto init remote &> /dev/null

  # test local repository
  assert "init_main() initialise existing repository with origin with local version" \
         "git describe HEAD" \
         "0.0.0"
  assert "init_main() initialise existing repository with origin with local branches" \
         "git branch --no-color --contains HEAD" \
         "* master"$'\n'"  release"  # force newline

  # test origin
  cd ../remote.git
  assert "init_main() initialise existing repository with origin with remote version" \
         "git describe HEAD" \
         "0.0.0"
  assert "init_main() initialise existing repository with origin with remote branches" \
         "git branch --no-color --contains HEAD" \
         "* master"$'\n'"  release"  # force newline

  cleanup
}

setup() {
  ROOT_TMP="$(mktemp -d)"
  cd "${ROOT_TMP}"
  trap cleanup EXIT
}

assert() {
  # an alias for swiss::test::assert.
  # globals:
  #   none
  # arguments:
  #   $@  same as swiss::test::assert, verbatim
  # returns:
  #   none
  swiss::test::assert "${@}"
}

cleanup() {
  cd "${ROOT_RUN}"
  rm -rf "${ROOT_TMP}"
}

main
