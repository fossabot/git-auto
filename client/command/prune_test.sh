#!/bin/bash
# this file is part of git-auto which is released under the mit license.
# go to http://opensource.org/licenses/mit for full details.

set -o nounset
set -o errexit

ROOT_TEST=$(readlink -f "${BASH_SOURCE[0]}" | xargs dirname)
source "${ROOT_TEST}/../../common/lib/swiss.sh/swiss.sh"
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
  start_suite "git auto prune"
    run_test git_auto_prune_main
  end_suite
}

git_auto_prune_main() {
  assert "echo invalid" "valid"
  return
}

main
