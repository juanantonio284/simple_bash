# `diff`

GNU Diffutils is a package of several programs (`diff`, `cmp`, `diff3`, `sdiff` ) related to finding
differences between files.

Computer users often find occasion to ask how two files differ. Perhaps one file is a newer version
of the other file. Or maybe the two files started out as identical copies but were changed by
different people.

You can use the `diff` command to show differences between two files, or each corresponding file in
two directories. `diff` outputs differences between files line by line in any of several formats,
selectable by command line options. This set of differences is often called a "diff" or "patch".

By default (with specific options passed): 

* For text files that are identical, `diff` produces no output
* For text files that are different, `diff` goes inside the file, compares, and gives a long output
* For binary (non-text) files, `diff` normally reports only that they are different

( Read the full manual [here][diffutils_manual_html] )

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Compare two folders

```BASH

cd path/to/directory
diff --recursive test_1 test_2 > output_diff_recursive.md

# -r --recursive: recursively compare any subdirectories found
# Be careful with the recursive option: 
# If there are text files with the same name in both folders, this option makes diff go inside those
# files, read, and compare them (i.e. it's not limited to folders and could take a long time)

# -q --brief: with this option, diff still goes inside the files and compares differences but gives
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
[diffutils_manual_html]: https://www.gnu.org/software/diffutils/manual/diffutils.html
