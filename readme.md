[Git Auto][linkedin]
====================
![GitHub version][version_badge] [![Build status][travis_image]][travis_status]
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fmraxilus%2Fgit-auto.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fmraxilus%2Fgit-auto?ref=badge_shield)

_Automating Git project management._

Usage
-----
To use Git auto, you must first install it (not working yet):

```sh
git clone https://github.com/mraxilus/git-auto.git git-auto
./git-auto/install.sh
```

You must then create a new directory, and initialise it as a Git auto repository:

```
mkdir hello_git_auto
cd hello_git_auto
git auto init
```

Now you have Git auto all setup!
The only left to do is add tests. 
Git auto will use them to automagically create releases on the release branch.
To do this, you must create a script to act as your test:

```sh
echo "\
#! bin/sh

exit 0
" > example_test.sh
```

Ignoring the fact that the test always passes, next you must register it with Git auto by modifying the configuration file:

```sh
echo "\
tests:
  example: ./example_test.sh
" > git-auto.yml
```

Every time we make a commit, Git auto will run our test.
It will also create a new release on the release branch if the tests exited in a succesful manner.
Git auto will also create a tag for each test, and update those tags to the last commit with which they passed on an individual basis.
That way you know which commit started the failure of a particular set of tests.
Git auto will only create a release if all tests pass on the latest commit.

Now, let's test it out by making a commit:

```sh
chmod +x example_test.sh
git add example_test.sh git-auto.yml
git commit --message="Add example test"
```

And we've just used Git auto!
\\(:D)/ ...but there's much more to Git auto than that.
I would suggest you check out the documentation (once it's arrives) to discover the true power of Git auto.
Until next time...

Purpose
-------
The idea of [git-flow][git_flow] is lovable, but using it doesn't fit with the mantra of automating everything.

License
-------
Copyright © Mr Axilus.
This project is licensed under [CC BY-NC-SA 4.0][license].

[git_flow]: https://github.com/nvie/gitflow
[license]: https://creativecommons.org/licenses/by-nc-sa/4.0/
[linkedin]: https://www.linkedin.com/in/mraxilus
[travis_image]: https://secure.travis-ci.org/mraxilus/git-auto.png?branch=master
[travis_status]: https://secure.travis-ci.org/mraxilus/git-auto
[version_badge]: https://badge.fury.io/gh/mraxilus%2Fgit-auto.svg 



## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fmraxilus%2Fgit-auto.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fmraxilus%2Fgit-auto?ref=badge_large)