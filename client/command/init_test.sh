#!/bin/bash
# this file is part of git-auto which is released under the mit license.
# go to http://opensource.org/licenses/mit for full details.

#set -o nounset
set -o errexit

ROOT_RUN=$(pwd)
ROOT_TEST=$(readlink -f "${BASH_SOURCE[0]}" | xargs dirname)
ROOT_HOOKS="${ROOT_TEST}/../hook"
source "${ROOT_TEST}/../../common/lib/swiss.sh/swiss.sh"
export PATH=${PATH}:${ROOT_TEST}/..

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
