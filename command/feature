#! /bin/sh

#
feature_finish() {
  if [[ "${1}" == "" ]]; then
    feature_usage
    exit 1
  fi

  branch="feature/$1"

  # merge into master
  git checkout master
  git merge --no-ff "$branch"
  git branch -d "$branch"
}

#
feature_publish() {
  # todo: implement feature publishing
  echo "publishing unimplemented"
}

#
feature_start() {
  git checkout -b "feature/$1" master
}

#
feature_usage() {
  log_info "usage: git auto feature <command> <arg>"
  log_info ""
  log_info "where available options for <command> are:"
  log_info "  finish  merge feature branch named <arg> into master and delete it"
  log_info "  publish push feature branch named <arg> to origin"
  log_info "  start   create new feature branch named <arg>"
  log_info ""
  log_info "for more command details run 'git auto <command> help'"
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
