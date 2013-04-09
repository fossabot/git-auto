# [git auto][1] ![build status][2]
*an attempt to seemingly automate git project management*

## usage
in order for us to get started with git auto, we must simply install it (via
some currently undefined process), create a new directory, and run:

```
git auto init
```

now we have git auto all setup! the only left to do is add tests which git
auto will use to automagically create releases on the master branch. first we
must create a script to act as our fake test:

**test_example.sh**
```
#! bin/sh

echo "test was successful"

exit 0
```

next we must register the test with git auto by creating a configuration file:

**git-auto.yaml**
```
tests:
  example: ./test_example.sh
```

every time we commit git auto will run our tests and create a new release on
the master branch if they all exited successfully. it will also create a tag
for each test on the develop branch and update those tags to the last commit
each of them passed on. that way you know what commit started the failure of a
particular test.

git auto will only create a release if all tests pass on a single commit
(there are plans to make it configurable in the future).

now, let's test it out by making a commit on develop:

```
git checkout develop
touch readme.md
git add readme.md
git commit --message="add readme"
...

execute "git auto test run all":
  test_example:
    test was successful

  test_example passed

  1 tests passed, 0 tests failed

update test tags:
  test_example -> ac56f0b

increment release to 0.0.1:
  merge develop -> master
```

and we've just successfully used git auto! \\(:D)/ ..but there's much more to
git auto than that. i would suggest you check out the documentation to
discover the true power of git auto. until next time..


## purpose
i love git flow, however i'm much too lazy to justify the use it. and thus, git
auto was born!


## documentation
### features
```
git auto feature start <optional branch name>
git auto feature finish <optional branch name, else current branch if feature>
git auto feature publish <optional branch name, else current branch if feature>
```


### versioning
```
git auto version bump minor <reason for version bump>
git auto version bump major <reason for version bump>
```


### tests
#### test failure history
```
git auto test show <optional test name, else all>
# example output:
#   tag:          unit tests
#   commit:   hash..
#   blame:     hash..
#   cause:     message of the commit where the test failed
```



### patches
```
git auto patch start <optional version tag to patch, else most recent version tag>
git auto patch finish <optional branch name, else current branch if patch>
```



## license
copyright © mr axilus [![flattr this][3]][4]

permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "software"), to deal
in the software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the software, and to permit persons to whom the software is
furnished to do so, subject to the following conditions:

the above copyright notice and this permission notice shall be included in all
copies or substantial portions of the software.

the software is provided "as is", without warranty of any kind, express or
implied, including but not limited to the warranties of merchantability,
fitness for a particular purpose and noninfringement. in no event shall the
authors or copyright holders be liable for any claim, damages or other
liability, whether in an action of contract, tort or otherwise, arising from,
out of or in connection with the software or the use or other dealings in the
software.

[1]: git-auto.projectaxil.us "git auto"
[2]: https://secure.travis-ci.org/mraxilus/git-auto.png?branch=master
[3]: http://api.flattr.com/button/flattr-badge-large.png
[4]: https://flattr.com/profile/mraxilus

