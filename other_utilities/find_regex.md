# Using `find` with regular expressions

## TLDR

**Key concept**: `regex` is a match on the whole path (the characters), it is not a "file search".  

For example, to match a file named `./fubar3`, you can use the expressions: 

* `.*bar.` or `.*b.*3`,

* not `f.*r3` (because there is no path that starts with '`f`', they always start with `./` at the
  current directory).[^note_regextype]

```Bash

# Look for file names
find -type f -regex ".*[Tt]inker.*"  # (i)
find -type f -iregex ".*tinker.*"    # (ii)
find -type f -iregex ".*tinker.*" | sed 's/\(\.\/folder_name_1\/Folder_name_2\/\)/...\//'  # (iii)

# (i): case sensitive regex (.* means any character one or more times)
# (ii): case insensitive regex 
# (iii): sed will remove "/folder_name_1/folder_name_2/" from the output and substitute with "..."

```

```Bash

# Look for certain file extensions
cd path/to/directory
find -type f -regex ".*\.\(txt\|md\)"              # (i)
find -type f -regex "\.\/.*\/.*\.\(txt\|md\)"      # (ii)
find -type f -regex "\.\/.*\/.*\.txt"              # (iii)
find -type f -iregex ".*file_name.*\.\(txt\|md\)"  # (iv)

# (i) Match for files with .txt or .md in their name at all levels including current directory
# (ii) Match for files with .txt or .md in their name at all subdirectory levels but NOT current dir
# (iii) Same as ii but only looking for .txt
# (iv) same as i but including a file name

```

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Example: searching for file extensions

Given a directory with the following content

* Files: `txt`, `File_1.txt`, `file_2.txt`, `file_4.md`, `file_3..txt`  

* Subdirectories (also containing files): `subdir_1`, `another_subdir_1`,
  `folder_name_with_letter_f` 

##### (i) Match for files with .txt or .md in their name at all levels including current directory

```Bash

cd path/to/directory

find -type f -regex ".*\.\(txt\|md\)" # .... (i)

```

* `.*` means any character one or more times
* `\.\(txt\|md\)` means ".txt or .md" 
     - the period before the file extension is included (that's why it's escaped `\.`) 
     - the parentheses and vertical line are all escaped `\( \| \)` as part of the *or* construction

*Sample output:*

```

You can see some files at current directory level, e.g. `./File_1.txt`

./File_1.txt
./test.txt
./subdir_1/file_inside_subdir_1.md
./subdir_1/subdir_2/file_inside_subdir_2.txt
./subdir_1/subdir_2/file_inside_subdir_2.md
./subdir_1/file_inside_subdir_1.txt
./file_4.md
./file_2.txt
./file_3..txt

```

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
##### (ii) Match for files with .txt or .md in their name at all subdirectory levels but NOT current directory

```Bash

find -type f -regex "\.\/.*\/.*\.\(txt\|md\)" # .... (ii)
find -type f -regex "        .*\.\(txt\|md\)" # .... previous example (i) adapted for comparison

```

`\.\/.*\/` is the part that differs from the previous example:

* `\.` is a period (`.`) escaped
* `\/` is a slash (`/`) escaped
* `.*` means any character one or more times
* `\/` is a slash (`/`) escaped

What we're looking for is `./any character/` which is a way of saying look for something that has a
folder above it.

*Sample output:*

```

There are no files at current directory level.

./subdir_1/file_inside_subdir_1.md
./subdir_1/subdir_2/file_inside_subdir_2.txt
./subdir_1/subdir_2/file_inside_subdir_2.md
./subdir_1/file_inside_subdir_1.txt

```

To aid understanding see code below. It is the same as (ii) but only looking for `.txt`

```Bash

find -type f -regex "\.\/.*\/.*\.txt" # .... (iii)

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Example: file names

### regex and iregex

```Bash

# look for a file with 'tinker' or 'Tinker' in its name (preceded or followed by any character)

find -type f -regex ".*[Tt]inker.*"
find -type f -iregex ".*tinker.*" # case insensitive regex

```

### using `sed` to clean up the output

```Bash

# sed will remove /folder_name_1/folder_name_2/ from the output and substitute with ... 
find -type f -iregex ".*tinker.*" | sed 's/\(\.\/folder_name_1\/Folder_name_2\/\)/...\//'

```

* In the code above, slashes not escaped are part of the sed syntax. These are:
    - the one here `s/`
    - the one after the closing parenthesis `)/`
    - the last one before the quotation mark `/'`
* parentheses need to be escaped `\(`
* the period `.` that signifies current directory needs to be escaped `\.`
* slashes `/` in the file path need to be escaped `\/`
* the `...` can be anything you want, and the escaped slash after it `\/` is there purely as an
  aesthetic choice


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## More Examples

```Bash

#                                  FIND FILES THAT START WITH F OR f

#      note that "\/[Ff]" places a slash before the F, this is the way we ensure that F is at the
#      start of the file name

find -type f -regex '\.\/[Ff].*' # search only in current directory
# "\.\/" is parsed as . escaped (\.), next to a / escaped (\/)
#        all this serves to pass the letters "./" at the start of the file name 
#        (file names that start with "./" are in the current directory)
# ".*" at the end means any character zero or more times following the F or f

# output:
# ./File_1.txt
# ./file_4.md
# ./file_2.txt
# ./file_3..txt

# ................................................

find -type f -regex '\.\/[^/]*\/[Ff][^/]*' # search only in first subdirectory level
# the components are "\.\/", "[^/]*", "\/", "[Ff]", and "[^/]*"
# "[^/]*" means negation ([^) of slash (/) zero or more times (*)
#         In this line, it's used to say "any character except a slash" (might help to think of it
#         as something equivalent to .* plus a negation of slash). 
# "\/" is one slash just for the first directory. 
# The "[^/]*" at the end serves to not expand search further than the first subdirectory (i.e. there
#             should be no slashes after the Ff so files inside further subdirectories that have
#             more than one slash in their names
#             like "./subdir_1/subdir_2/file_inside_subdir_2.txt" would not be found) 

# output:
# ./subdir_1/file_inside_subdir_1.md
# ./subdir_1/file_inside_subdir_1.txt

# ................................................

find -type f -regex '\.\/.*\/[Ff].*' # search at all subdirectory levels but NOT at CD level
# the components are "\.\/", ".*", "\/", "[Ff]", and "[^/]*"
# ".*\/" means "at least one slash" aside from the first one to ask for CD, this puts you at subdir 
#        level. In other words the combination of ".*" and "\/" means you are looking for a slash
#        (a subdirectory), preceded by any character (which could be a slash)
# Note that this is the same as the previous example but [^/]* has been changed for .*, which means
# that slashes are not negated any more

# output:
# ./subdir_1/file_inside_subdir_1.md
# ./subdir_1/subdir_2/file_inside_subdir_2.txt
# ./subdir_1/subdir_2/file_inside_subdir_2.md
# ./subdir_1/file_inside_subdir_1.txt

# ................................................

find -type f -regex '.*[Ff].*' # FLAWED
# Finds Ff at any point in the path, not just at the start of the file
# .*, at the beginning means any character zero or more times, which means that it could be any
#     number of slashes (file names that have many slashes preceding it are in subdirectories)

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
# References

* https://www.man7.org/linux/man-pages/man1/find.1.html
* https://linuxhandbook.com/find-with-regex/


[^note_regextype]: The regular expressions understood by `find` are by default Emacs Regular
Expressions (except that `.` matches newline), but this can be changed with the `-regextype`
option.
