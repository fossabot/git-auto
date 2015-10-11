#!/bin/bash

set -o nounset
set -o errexit

ROOT_TEST=$(readlink -f "${BASH_SOURCE[0]}" | xargs dirname)
source "${ROOT_TEST}/../../library/swiss.sh/swiss.sh"
export PATH=${PATH}:${ROOT_TEST}/..  # make git auto runnable

# setup library aliases
assert()      { swiss::test::assert      "${@}"; }
end_suite()   { swiss::test::end_suite   "${@}"; }
end_test()    { swiss::test::end_test    "${@}"; }
run()         { swiss::test::run         "${@}"; }
run_test()    { swiss::test::test        "${@}"; }
start_suite() { swiss::test::start_suite "${@}"; }
start_test()  { swiss::test::start_test  "${@}"; }

main() {
  start_suite "git auto patch"
    run_test git_auto_patch_start
    run_test git_auto_patch_push
    run_test git_auto_patch_pull
    run_test git_auto_patch_finish
  end_suite
}

git_auto_patch_start() {
  assert "echo invalid" "valid"
  return
}

git_auto_patch_push() {
  assert "echo invalid" "valid"
  return
}

git_auto_patch_pull() {
  assert "echo invalid" "valid"
  return
}

git_auto_patch_finish() {
  assert "echo invalid" "valid"
  return
}

main

