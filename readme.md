[git auto][1] [![build status][2]][3] [![gitter][4]][5] [![stories in ready][10]][11] [![google analytics][6]][7]
=============
_an attempt to seemingly automate git project management_

usage
-----
first, 
  you must install it (not working yet):

```sh
git clone https://github.com/mraxilus/git-auto.git git-auto
./git-auto/install.sh
```

next,
  you should create a new directory,
  and initialise it as a git auto repository:

```
mkdir hello_git_auto
cd hello_git_auto
git auto init
```

now you have git auto all setup!
the only left to do is add tests. 
git auto will use them to automagically create releases on the release branch.
in order to do this you must create a script to act as your test:

```sh
echo "\
#! bin/sh

exit 0
" > example_test.sh
```

ignoring the fact that the test always passes,
next you must register it with git auto by modifying the configuration file:

```sh
echo "\
tests:
  example: ./example_test.sh
" > git-auto.yml
```

every time we make a commit git auto will run our test.
it will also create a new release on the release branch if the tests exited successfully.
in addition,
  it will also create a tag for each test,
  and update those tags to the last commit with which they passed individually.
that way you know which commit started the failure of a particular set of tests.
git auto will only create a release if all tests pass on the latest commit.

now,
  let's test it out by making a commit:

```sh
chmod +x example_test.sh
git add example_test.sh git-auto.yml
git commit --message="add example test"
```

and we've just successfully used git auto!
\\(:D)/ ...but there's much more to git auto than that.
i would suggest you check out the documentation to discover the true power of git auto.
until next time...

purpose
-------
the idea of [git flow][8] is lovable,
  however using it properly doesn't fit with the mantra of ultimate laziness.
and thus,
  git auto was born!

documentation
-------------
for more information please consult the [wiki][9].

license
-------
copyright © mr axilus.
<a class="coinbase-button" data-code="c060c048abd9fe7b4f36021738451bed" data-button-style="donation_small" href="https://coinbase.com/checkouts/c060c048abd9fe7b4f36021738451bed">sponsor</a> with bitcoins.

permission is hereby granted,
  free of charge,
  to any person obtaining a copy of this software and associated documentation files (the "software"),
  to deal in the software without restriction,
  including without limitation the rights to use,
  copy,
  modify,
  merge,
  publish,
  distribute,
  sublicense,
  and/or sell copies of the software,
  and to permit persons to whom the software is furnished to do so,
  subject to the following conditions:

the above copyright notice and this permission notice shall be included in all copies or substantial portions of the software.

the software is provided "as is",
  without warranty of any kind,
  express or implied,
  including but not limited to the warranties of merchantability,
  fitness for a particular purpose and noninfringement.
in no event shall the authors or copyright holders be liable for any claim,
  damages or other liability,
  whether in an action of contract,
  tort or otherwise,
  arising from,
  out of or in connection with the software or the use or other dealings in the software.

<!-- extrenal project page -->
[1]: {{github.project.url}} "{{github.project.name}}"

<!-- travis -->
[2]: https://secure.travis-ci.org/mraxilus/git-auto.png?branch=master
[3]: https://secure.travis-ci.org/mraxilus/git-auto

<!-- gitter -->
[4]: http://badges.gitter.im/{{github.username}}.png
[5]: https://gitter.im/{{github.username}}/{{github.project.name}}

<!-- google analytics -->
[6]: https://ga-beacon.appspot.com/{{google.tracking_id}}/{{github.project.name}}/readme.md
[7]: https://github.com/igrigorik/ga-beacon

[8]: https://github.com/nvie/gitflow

<!-- wiki -->
[9]: https://github.com/{{github.username}}/{{github.project.name}}/wiki

<!-- waffle.io -->
[10]: https://badge.waffle.io/mraxilus/git-auto.png?label=ready&title=ready
[11]: https://waffle.io/mraxilus/git-auto

