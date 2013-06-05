#! /bin/sh

# todo: argument checking for functions

## functions
#
finish() {
  branch="feature/$1"
  git checkout -q master
  git merge -q --no-ff "$branch"
  git branch -qd "$branch"
}

#
publish() {
  # todo: implement feature publishing
  echo "publishing unimplemented"
}

#
start() {
  git checkout -qb "feature/$1" master
}

#
usage() {
  echo -e "usage: git auto feature <command> <arg>"
  echo -e "\nwhere available options for <command> are:"
  echo -e "  finish\tmerge feature branch named <arg> into master and delete it"
  echo -e "  publish\tpush feature branch named <arg> to origin"
  echo -e "  start\t\tcreate new feature branch named <arg>"
  echo -e "\nfor more command details run 'git auto <command> help'"
}


## main
option=$1
shift

case $option in
  finish)  finish $@  ;;
  publish) publish $@ ;;
  start)   start $@   ;;
  *)       usage              ;;
esac
