# Create a new directory with a cloned directory structure

## TLDR

Given `directory_1` (the template directory), find out which folders are inside it.  
Create `directory_2` and, inside it, create empty folders with same names and structure as those of 
`directory_1`.

```Bash

cd path/to/directory_1/
tree -dfi --noreport | xargs -I{} mkdir -p "$HOME/path/to/directory_2/{}"  # i

tree -a /path/to/directory_2/                                              # ii

#  i: Note how it says $HOME and not ~ or something else
# ii: Optional (verify)

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Part 1: getting to know the `tree` utility

Use the [tree utility][tree] to display a tree view of directories. 

**Basic usage**

```Bash

cd path/to/directory/
tree -d # list directories only

# output to text file with line below
# tree -d > this_directorys_structure.txt 

```

**Output directory structure to text**

```Bash

cd path/to/directory/
tree -dfi --noreport

# Where: 
# --noreport:      omits printing of the file and directory report at the end of the tree listing
# -d  directories, list directories only
# -f  full, print the full path prefix for each file
# -i  indentation, do not print the indentation lines, useful when used in conjunction with the -f
#     option. (Also removes as much whitespace as possible when used with the -J or -X options.)

# (You could also do "tree -dfi --noreport path/to/directory")

```

Sample output:

```
.
./subdir_1
./subdir_1/subdir_2
./test_directory
./test_directory/subdir_1
./test_directory/subdir_1/subdir_2
```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Part 2: using `xargs` to create the new directories

`xargs` serves to build and execute command lines from standard input. 

The lines below below will: 

1. Change directory to `directory_1`.
2. Use `tree` to get `directory_1`'s structure and output it to text (as in the sample output in the
previous section).
3. Pipe (`|`) that text output into `xargs`.
4. `xargs` uses its text input to replace `{}` in the line passed to the `mkdir` command. This
creates `directory_2` and, inside it, all the same folders that `directory_1` has.

```Bash

cd path/to/directory_1/
tree -dfi --noreport | xargs -I{} mkdir -p "$HOME/path/to/directory_2/{}"
# Note how it says $HOME and not ~ or something else

# Where:
# -I{}: replace occurrences of {} in the initial-arguments with names read from standard input
#       ({} can be any string to replace, aka "replace-str")

# -p, --parents: no error if existing, make parent directories as needed, with their file modes
#                unaffected by any -m option (this is an argument for the mkdir command)
#                This means create directory_2 if it does not exist, or use it without creating
#                erros if it does

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## References

https://www.tutorialspoint.com/copy-directory-structure-without-files-on-linux


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
[tree]: https://oldmanprogrammer.net/source.php?dir=projects/tree
