# `diff`

## TLDR

**An option to avoid problems with large files**

```Bash

# 1
diff <(find /path/to/directory1/ -printf '%P\n') \
     <(find /path/to/directory2/ -printf '%P\n')

# 2
cd path/to/directory
diff <(find test_1 -printf '%P\n') \
     <(find test_2 -printf '%P\n') \
     > output.txt

# 2
cd path/to/directory
diff --side-by-side <(find test_1 -printf '%P\n') \
                    <(find test_2 -printf '%P\n') \
                    > output.txt

```

**A more traditional option**

```BASH

cd path/to/directory
diff --recursive test_1 test_2 > output_diff_recursive.md

# Be careful with the recursive option: 
# If there are files with the same name in both folders, this option makes diff go inside those
# files, read, and compare them (i.e. it's not limited to folders and could take a long time)

```

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Introduction

GNU Diffutils is a package of several programs (`diff`, `cmp`, `diff3`, `sdiff` ) related to finding
differences between files.

Computer users often find occasion to ask how two files differ. Perhaps one file is a newer version
of the other file. Or maybe the two files started out as identical copies but were changed by
different people.

You can use the `diff` command to show differences between two files, or each corresponding file in
two directories. `diff` outputs differences between files line by line in any of several formats,
selectable by command line options. This set of differences is often called a "diff" or "patch".

* Read the full manual [here][diffutils_manual_html]
* See the options to diff [here][diff_options]
* [Same as above?][man7_diff] Nicer to read maybe

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Compare two folders

```BASH

cd path/to/directory
diff --recursive test_1 test_2 > output_diff_recursive.md

# -r --recursive: recursively compare any subdirectories found
# Be careful with the recursive option: 
# If there are files with the same name in both folders, this option makes diff go inside those
# files, read, and compare them (i.e. it's not limited to folders and could take a long time)

# -q --brief: with this option, diff STILL goes inside the files and compares differences but gives
#             a cleaner output, e.g "Files test_1/file.txt and test_2/file.txt differ"
#             "This format is especially useful when comparing the contents of two directories. It
#              is also much faster than doing the normal line by line comparisons, because diff can
#              stop analyzing the files as soon as it knows that there are any differences."

# > is used to output to a file

```

### Example

* `test_1` and `test_2` are folders
* `test_1` contains the folders `folder_a`, `folder_b`, `folder_c`, `folder_d`
    -  `test_1/folder_a/` contains the folder `folder_inside_a`
    -  `test_2/folder_a/` is empty
* `test_2` contains the folders `folder_a`, `folder_b`, `folder_c`, and does not contain `folder_d`

Then, the line `diff --recursive test_1 test_2` will produce the following output:

```
Only in test_1/folder_a: folder_inside_a
Only in test_1: folder_d
```

This indicates that `folder_inside_a` is found only in `test_1/folder_a/` 
(and not in `test_2/folder_a`). 
It also indicates that `folder_d` is only in `test_1`.


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Problem with large files!

The manual says the [following][diff_manual_binary]

> If `diff` thinks that either of the two files it is comparing is binary (a non-text file), it
  normally treats that pair of files much as if the summary output format had been selected
  (see Summarizing Which Files Differ), and reports only that the binary files are different. This
  is because line by line comparisons are usually not meaningful for binary files. This does not
  count as trouble, even though the resulting output does not capture all the differences.
> 
> `diff` determines whether a file is text or binary by checking the first few bytes in the file;
  the exact number of bytes is system dependent, but it is typically several thousand. If every
  byte in that part of the file is non-null, `diff` considers the file to be text; otherwise it
  considers the file to be binary.
  
**Ultimately**, this means that `diff` reads every file, text and binary—least part of it—which can
  make the process very slow. And, the `-q, --brief` option is not a solution (`diff` STILL goes
  inside the files, even if it gives a cleaner output.)
  
(Content below from here: https://stackoverflow.com/a/5344869)

When files are different `diff` will be able to figure that out fairly quickly. When they're the
same, though, it has to scan the files in full to verify that they are indeed byte-for-byte
identical.

If all you care about is differences in file names and don't want to inspect the contents of the
files, try something like:

```Bash

diff <(find /Volumes/directory1/ -printf '%P\n') \
     <(find /Volumes/directory2/ -printf '%P\n')

# printf is an option for the gnu find utility (it is not the separate utility, part of coreutils)
#   '%P\n' is the format with which printf will print. 
#       Here:
#         %P: file's name with the name of the starting-point under which it was found removed
#         \n: new line

```

Since it's only fetching and comparing the files' names, not their contents, it'll run very fast
(but not detect if the two directories have files with matching names but different contents).

The code above assumes you have [GNU find][find_manual] with the `-printf` action. If you don't, use
some subshell magic: 

```Bash

diff <(cd /Volumes/directory1; find .) \
     <(cd /Volumes/directory2; find .)

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
[diffutils_manual_html]: 
https://www.gnu.org/software/diffutils/manual/diffutils.html

[diff_options]: 
https://www.gnu.org/software/diffutils/manual/diffutils.html#diff-Options

[man7_diff]: 
https://man7.org/linux/man-pages/man1/diff.1.html

[diff_manual_binary]: 
https://www.gnu.org/software/diffutils/manual/diffutils.html#Binary

[find_manual]: 
https://man7.org/linux/man-pages/man1/find.1.html
