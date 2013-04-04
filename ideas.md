# seperate drastic changes
```
git auto feature start <optional branch name>
git auto feature finish <optional branch name, else current branch if feature>
git auto feature publish <optional branch name, else current branch if feature>
```

# fix a defect
```
git auto patch start <optional version tag to patch, else most recent version tag>
git auto patch finish <optional branch name, else current branch if patch>
```

# duplicates the last version tag and bumps the specified count by 1
```
git auto version bump minor <reason for version bump>
git auto version bump major <reason for version bump>
```

# test failure history
```
git auto test show <optional test name, else all>
# example output:
#   tag:          unit tests
#   commit:   hash..
#   blame:     hash..
#   cause:     message of the commit where the test failed
```
