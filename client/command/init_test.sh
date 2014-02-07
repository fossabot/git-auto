#!/bin/bash
# this file is part of git-auto which is released under the mit license.
# go to http://opensource.org/licenses/mit for full details.

#set -o nounset
#set -o errexit

RUN_ROOT=$(pwd)
TEST_ROOT=$(readlink -f "${BASH_SOURCE[0]}" | xargs dirname)
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
  setup

  # run tests
  assert "git auto usage" "git auto" "usage: git auto <command>

where available options for <command> are:
  feature: start, finish, or publish feature branch
  init:    initialize repository to be compatible with git auto
  patch:   start, finish, or publish patch on existing release
  prune:   remove stray merged branches within the repository
  test:    run or show status of tests
  version: manually manage release versions

for more command details run 'git auto <command>'" "1"

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
