#!/bin/bash
# this file is part of git-auto which is released under the mit license.
# go to http://opensource.org/licenses/mit for full details.

#set -o nounset
#set -o errexit

RUN_ROOT=$(pwd)
TEST_ROOT=$(readlink -f "${BASH_SOURCE[0]}" | xargs dirname)
HOOKS_ROOT="${TEST_ROOT}/../hook"
source "${TEST_ROOT}/../../common/lib/swiss.sh/swiss.sh"
export PATH=${PATH}:${TEST_ROOT}/..

main() {
  # test suite which verifies that the feature command functions correctly.
  # globals:
  #   none
  # arguments:
  #   none
  # returns:
  #   none
  git_auto_init_installs_hooks
  git_auto_init_initialises_new_repository
}

git_auto_init_installs_hooks() {
  setup
  git auto init &> /dev/null
  assert "init_main() installs hooks" \
         "ls .git/hooks/ | sed '/.*sample$/d'" \
         "$(ls ${HOOKS_ROOT}/)"
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

setup() {
  cd "$(mktemp -d)"
}

cleanup() {
  cd "${RUN_ROOT}"
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

main
