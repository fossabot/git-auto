#! /bin/sh

#
feature_finish() {
  branch="feature/$1"

  # merge into master
  git checkout -q master
  git merge -q --no-ff "$branch"
  git branch -qd "$branch"
}

#
feature_publish() {
  # todo: implement feature publishing
  echo "publishing unimplemented"
}

#
feature_start() {
  git checkout -qb "feature/$1" master
}

#
feature_usage() {
  log_info "usage: git auto feature <command> <arg>"
  log_info "\nwhere available options for <command> are:"
  log_info "  finish\tmerge feature branch named <arg> into master and delete it"
  log_info "  publish\tpush feature branch named <arg> to origin"
  log_info "  start\t\tcreate new feature branch named <arg>"
  log_info "\nfor more command details run 'git auto <command> help'"
}

#
feature_main() {
  # parse command line options
  option=$1
  shift
  case $option in
    finish)  feature_finish  $@ ;;
    publish) feature_publish $@ ;;
    start)   feature_start   $@ ;;
    *)       feature_usage      ;;
  esac
}
