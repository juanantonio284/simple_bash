# `find` (GNU find)

## Find a file using part of a name (case insensitive)

```Bash

cd path/to/directory
find -iname "*file*"
# -iname: (case) insensitive name of file
# "*file*" means match f zero or more times followed by i and l, followed by e zero or more times

```

```Bash

# could also put the path in the command
find path/to/directory -iname "*file*"

```

The code above could give the output below.  
"file" is *preceded* or *followed* by anything (e.g. `..._file` or `file_...`)

```

./File_1.txt
./file3
./subdir_1/subdir_2/file_inside_subdir_2.txt
./subdir_1/file_inside_subdir_1.txt
./pdf_ocr_test/my_test_file.pdf
./some_file

```

##### Example 1

```Bash

cd path/to/directory
find -iname "file*"

```

The code above could give the output below.  
"file" is always at the beginning, *followed* by anything (the last two options from the previous 
output are not seen here)

```

./File_1.txt
./file3
./subdir_1/subdir_2/file_inside_subdir_2.txt
./subdir_1/file_inside_subdir_1.txt

```

##### Example 2

**Find file names and dump to text file**

```Bash

# find files with pdf extension
find path/to/directory -iname '*.pdf' > path/to/directory/output_file.txt

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Find a directory

(Same as previous examples, just use the `-type d` argument)

```Bash

find -type d -iname directory_name
# -type d: searches for directories
# in this example it is looking for the directory with exact name "directory_name"

```

##### Example 1

**Find empty directories, empty files, hidden files**

```Bash

# find all empty directories
find path/to/directory -type d -empty  # d means "directory"

# find all empty files
find path/to/directory -type f -empty  # f means "regular file"

# find all hidden files
find path/to/directory -type f -name ".*"  # hidden files start with .

```

##### Example 2

```Bash

find -type d -name "*subdir_*"

```

The code above could give the output below. (You can see "subdir_" *followed* by anything, which in
this case is either `1` or `2`)

```

./subdir_1
./subdir_1/subdir_2

```

Note the difference: the code below

```Bash

find -type d -name "*subdir_1*"

```

only gives this

```

./subdir_1

```

which shows that it's not the path string `./subdir_1/subdir_2` that is considered because then you
would expect that `subdir_1` is followed by `/subdir_2` but it really is one directory at a time
where the pattern is matched. This would change if using the `-regex` flag, see other file.


<!-- maybe look at this site -->
<!-- https://www.tecmint.com/35-practical-examples-of-linux-find-command/ -->
<!-- Part III – Search Files Based On Owners and Groups -->
