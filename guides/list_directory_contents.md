# Listing a Directory's Contents

## TLDR

```Bash
cd path/to/directory
ls -RF --group-directories-first | sed -f script2.sed > 0_folder_contents.md
```

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Basic Idea

```Bash
cd path/to/directory
ls -RF --group-directories-first > 0_folder_contents.md

# -R, --recursive: list subdirectories recursively
# -F, --classify: append indicator (one of */=>@|) to entries
#                                  / for directories
#                                  nothing for files
#                                  * for executables

```
See more on the `-F` flag [here][ls-F]

## Using the `sed` command to improve readability

**1.** Create a script-file named `script2.sed` (or whatever you want) with commands for finding and
  replacing patterns. 

```Bash
cd path/to/directory
cat > script2.sed

# enter text below
s@\.:@#\ Top\ Directory@
s@\.\/@##\ \.\/@g
s@\/$@\ \ **Directory**@g

# Recall that the syntax of the s command is ‘s/regexp/replacement/flags’.
# Here, @ has been used instead of / to make it easier to read, as there were many 
# escaped slashes \/, being that we are dealing with directories.

# Thus, the last line is:
# 1. The s command (for substitute), followed by an @.
# 2. A regexp (the pattern to look for), which is \/$ (an escaped slash at the end of the line),
#    followed by an @
# 3. The replacement, which is \ \ **Directory** (two escaped spaces and the word **Directory**), 
#    followed by an @
# 4. The g flag (for "global" substitution, i.e. all instances)
```

**2.** Apply

```Bash

# cd path/to/directory
ls -RF --group-directories-first > 0_folder_contents.md
sed -f script2.sed 0_folder_contents.md > clean_folder_contents.md

# all in one line
ls -RF --group-directories-first | sed -f script2.sed > 0_folder_contents.md

# same as above but outside of the script file, just for testing
# ls -RF --group-directories-first | sed s/"\/$"/"   **Directory**"/g > 0_folder_contents.md
# ls -RF --group-directories-first | sed s/"\.\/"/"## \.\/"/g > 0_folder_contents.md

```

[ls-F]: https://www.gnu.org/software/coreutils/manual/coreutils.html#index-_002dF-3
