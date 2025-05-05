# Listing a Directory's Contents

## TLDR

1. Create script-file (see "An improvement ..." below)

2. Run lines below

```Bash
cd path/to/directory/
ls -RF --group-directories-first | sed -f script2.sed > 0_folder_contents.md
```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Basic Idea

```Bash
cd path/to/directory/
ls -RF --group-directories-first > 0_folder_contents.md

# -R, --recursive: list subdirectories recursively
# -F, --classify: append indicator (one of */=>@|) to entries
#                                  / for directories
#                                  nothing for files
#                                  * for executables

# note that the -F flag might cause the * to appear in many places where it shouldn't ...

```
See more on the `-F` flag [here][ls-F]

## An improvement: using the `sed` command to improve readability

**1.** Create a script-file named `script2.sed` (or whatever you want) with commands for finding and
  replacing patterns. 

```Bash
cd path/to/directory/
cat > script2.sed

# enter text below
s@\.:@#\ Top\ Directory@
s@\.\/@##\ \.\/@g
s@\/$@\ \ **Directory**@g

# Recall that the syntax of the s command is ‘s/regexp/replacement/flags’.
# In this example @ has been used instead of / to make it easier to read, as there were many 
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

cd path/to/directory/

# Option 1
ls -RF --group-directories-first > 0_folder_contents.md
sed -f script2.sed 0_folder_contents.md > clean_folder_contents.md

# Option 2 (all in one line)
ls -RF --group-directories-first | sed -f script2.sed > 0_folder_contents.md

```

Extra (code for testing)

```Bash

# same as above but outside of the script file, just for testing
# ls -RF --group-directories-first | sed s/"\/$"/"   **Directory**"/g > 0_folder_contents.md
# ls -RF --group-directories-first | sed s/"\.\/"/"## \.\/"/g > 0_folder_contents.md

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Other options to consider

### 1

```Bash

cd path/to/directory/
ls -RFsh > 0_folder_contents_RFsh.md
# -s, --size: print the allocated size of each file, in blocks
# -h, --human-readable: with -l and -s, print sizes like 1K 234M 2G etc.
# Note: the size printed is not all that accurate, need to add (or use different)) options to get
# the expected output

```

This will give an output that's not so easy to read. More on the ls command [here][ls_command]


### 2

Use lines below to find and replace text in a text editor and organize the output file

```markdown

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
# 1st level directories

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## 2nd level directory 

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### 3rd level directories

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->

```




<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->

[ls-F]: https://www.gnu.org/software/coreutils/manual/coreutils.html#index-_002dF-3
[ls_command]: https://www.gnu.org/software/coreutils/manual/html_node/ls-invocation.html
