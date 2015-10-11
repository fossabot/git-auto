#!/bin/bash

set -o nounset
set -o errexit

ROOT_TEST=$(readlink -f "${BASH_SOURCE[0]}" | xargs dirname)
ROOT_HOOKS="${ROOT_TEST}/../hook"
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
  start_suite "git auto init"
    run_test git_auto_init_installs_hooks
    run_test git_auto_init_initialises_new_repository
    run_test git_auto_init_initialises_existing_repository
    run_test git_auto_init_initialises_existing_repository_with_origin
    run_test git_auto_init_initialises_existing_repository_with_remote
  end_suite
}

git_auto_init_installs_hooks() {
  run "git auto init"
  assert "ls .git/hooks/ | sed '/.*sample$/d'" "$(ls ${ROOT_HOOKS}/)"
}

git_auto_init_initialises_new_repository() {
  run "git auto init"
  assert_version_valid
  assert_branches_valid
}

git_auto_init_initialises_existing_repository() {
  run "git init" 
  run "git commit --allow-empty --message='this repository exists'"
  run "git auto init"
  assert_version_valid
  assert_branches_valid
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
  assert_version_valid
  assert_branches_valid

  # test origin
  run "cd '../${remote}.git'"
  assert_version_valid
  assert_branches_valid
}

assert_version_valid() {
  # 
  # globals:
  #   none.
  # arguments:
  #   none.
  # returns:
  #   none.
  assert "git describe HEAD" "0.0.0"  # check if version is correct.
}

assert_branches_valid() {
  # 
  # globals:
  #   none.
  # arguments:
  #   none.
  # returns:
  #   none.
  assert "git branch --no-color --contains HEAD" \
         "* master"$'\n'"  release"  # force newline
}

main

