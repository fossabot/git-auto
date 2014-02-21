#!/bin/bash
# this file is part of git-auto which is released under the mit license.
# go to http://opensource.org/licenses/mit for full details.

set -o nounset
set -o errexit

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
  run "git auto init"
  assert "init_main() installs hooks" \
         "ls .git/hooks/ | sed '/.*sample$/d'" \
         "$(ls ${ROOT_HOOKS}/)"
  cleanup
}

git_auto_init_initialises_new_repository() {
  setup
  run "git auto init"
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
  run "git init" 
  run "git commit --allow-empty --message='this repository exists'"
  run "git auto init"
  assert "init_main() initialise existing repository with version" \
         "git describe HEAD" \
         "0.0.0"
  assert "init_main() initialise existing repository with branches" \
         "git branch --no-color --contains HEAD" \
         "* master"$'\n'"  release"  # force newline
  cleanup
}

git_auto_init_initialises_existing_repository_with_origin() {
  git_auto_init_initialises_existing_repository_with_remote origin
}

git_auto_init_initialises_existing_repository_with_remote() {
  # test for initialisation of existing repository with named remote.
  # globals:
  #   none
  # arguments:
  #   $1: remote name to use.
  # returns:
  #   none
  setup
  local remote=${1:-remote}

  # setup remote and local repository.
  run "mkdir '${remote}.git'"
  run "cd '${remote}.git'"
  run "git init --bare"
  run "cd .."
  run "git clone '${remote}.git' local_repository"
  run "cd local_repository"
  run "git commit --allow-empty --message='this repository exists'" 
  run "git remote rename origin '${remote}'"
  run "git auto init ${remote}"

  # test local repository
  assert "init_main() initialise existing repository with ${remote} with local version" \
         "git describe HEAD" \
         "0.0.0"
  assert "init_main() initialise existing repository with ${remote} with local branches" \
         "git branch --no-color --contains HEAD" \
         "* master"$'\n'"  release"  # force newline

  # test origin
  run "cd '../${remote}.git'"
  assert "init_main() initialise existing repository with ${remote} with remote version" \
         "git describe HEAD" \
         "0.0.0"
  assert "init_main() initialise existing repository with ${remote} with remote branches" \
         "git branch --no-color --contains HEAD" \
         "* master"$'\n'"  release"  # force newline

  cleanup
}

setup() {
  ROOT_TMP="$(mktemp -d)"
  cd "${ROOT_TMP}"
}

run() {
  eval "$@" &> /dev/null || true
}

assert() {
  # an alias for swiss::test::assert.
  # globals:
  #   none
  # arguments:
  #   $@: same as swiss::test::assert, verbatim
  # returns:
  #   none
  swiss::test::assert "${@}"
}

cleanup() {
  cd "${ROOT_RUN}"
  rm -rf "${ROOT_TMP}"
}

main
