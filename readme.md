# [git auto][1] [![build status][2]][3]
*an attempt to seemingly automate git project management*

## usage
in order for us to get started, we must install it (via some currently
undefined process), create a new directory, and run:

```
> git auto init
```

now we have git auto all setup! the only left to do is add tests. git auto will
use them to automagically create releases on the release branch. first we must
create a script to act as our test:

**example_test.sh**
```
#! bin/sh

exit 0
```

ignoring the fact that the test always passes, next we must register it with
git auto by modifying the configuration file:

**git-auto.yaml**
```
tests:
  example: ./example_test.sh
```

every time we make a commit git auto will run our test. it will also create a
new release on the release branch if the tests exited successfully. in addition
it will also create a tag for each test and update those tags to the last
commit each of them passed on. that way you know which commit started the
failure of a particular test.

git auto will only create a release if all tests pass on the latest commit.

now, let's test it out by making a commit:

```
> chmod +x example_test.sh
> git add example_test.sh
> git commit --message="add example test"
...
run all tests:
  [run   ] example
  [  pass] example (1ms)
  0 tests failed, 1 test passed, 1 test ran
update test tags:
  example -> ac56f0b
increment release:
  merge master -> release
  tag as version 0.0.1
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
git auto feature start <branch name>
git auto feature finish <branch name>
git auto feature publish <branch name>
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
```

### patches
```
git auto patch start <branch name>
git auto patch finish <branch name>
git auto patch publish <branch name>
```

## license
copyright © mr axilus <a class="coinbase-button" data-code="c060c048abd9fe7b4f36021738451bed" data-button-style="donation_small" href="https://coinbase.com/checkouts/c060c048abd9fe7b4f36021738451bed">donate bitcoins</a><script src="https://coinbase.com/assets/button.js" type="text/javascript"></script>

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
[3]: https://secure.travis-ci.org/mraxilus/git-auto
