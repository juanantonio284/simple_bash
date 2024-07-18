# `grep`

<!-- from official documentation -->

## Introduction

Given one or more patterns, **grep searches input files for matches to the patterns**.

When it finds a match in a line, it copies the line to standard output (by default)—i.e. it prints
each line that matches a pattern.

Though grep expects to do the matching on text, it has no limits on input line length other than
available memory, and it can match arbitrary characters within a line. 

Since newline is also a separator for the list of patterns, there is no way to match newline
characters in a text.

[(Complete documentation here)][grep_doc]
[grep_doc]: https://www.gnu.org/software/grep/manual/

<!-- Content below from -->
<!-- Chapter 1. Essential Command Line Tools, Lesson 4: Finding strings: `grep` -->

`grep` stands for "`global regular expression print`", which points out that it can do more than
match simple strings. It can work with more complicated regular expressions which can contain
wildcards and other special attributes.

**Simplest example**

```Bash

grep pig file

# finds three instances of the string "pig" in file:
# pig
# dirty pig
# pig food

```

**Another example**

```Bash

grep -i -e pig -e dog -r

```
will search all files in the current directory and those below it (`-r`) for the strings
(`-e`) "pig" or "dog", ignoring case (`-i`).

**More examples**:

```Bash

grep "^dog" file # print all lines that start with "dog"
grep "dog$" file # print all lines that end with "dog"
grep d[a-p] file # print all lines with a d followed by a character from a to p

```

### `grep` options

`grep` has many options. Some of the most important are listed in the table below:

| **Option** |                                  **Meaning**                                  |
|:----------:|:-----------------------------------------------------------------------------:|
|     -i     |                                  Ignore case                                  |
|     -v     |                                  Invert match                                 |
|     -n     |                               Print line number                               |
|     -H     |                                 Print filename                                |
|     -a     |                           Treat binary files as text                          |
|     -I     |                              Ignore binary files                              |
|     -r     |                         Recurse through subdirectories                        |
|     -l     |               Print out names of all files that contain matches               |
|     -L     |            Print out names of all files that do not contain matches           |
|     -c     |                    Print out number of matching lines only                    |
|     -e     | Use the following pattern; useful for multiple strings and special characters |


**Note**: 

`-e PATTERNS` (or `--regexp=PATTERNS`)

* If these options are used multiple times, or are combined with the  -f(--file)  option, `grep`
  searches for all patterns given

* These options can be used to protect a pattern beginning with “`-`”

* PATTERNS shows where the search pattern should be placed

### Common Combinations

<!-- Content below from  -->
<!-- Chapter 2. File and Text Manipulation Utilities / grep and strings -->


``` 

  COMMAND                            USAGE

grep [pattern] <filename>       Search for a pattern in a file and print all matching lines
grep -v [pattern] <filename>    Print all lines that do not match the pattern
grep [0-9] <filename>           Print the lines that contain the numbers 0 through 9
grep -C 3 [pattern] <filename>  Print context of lines (specified number of lines above and below 
                                the pattern) for matching the pattern. Here, the number of lines is
                                specified as 3

```

<!-- Content below from  -->
<!-- Chapter 2. File and Text Manipulation Utilities / grep and strings -->
### The `strings` command

The `strings` command is used to extract all printable character strings found in the file or files
given as arguments. **It is useful in locating human-readable content embedded in binary files**
(for text files one can just use grep).

For example, to search for the string `my_string` in a spreadsheet:

```Bash

strings book1.xls | grep my_string

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->

<!-- Content below from -->
<!-- Chapter 1. Essential Command Line Tools, Lab 1.2. Using 'grep' -->
# Lab

**Find all entries in the `/etc/services` file that include the string "`ftp`"**

```Bash

grep ftp /etc/services

```

**Restrict to those that use the `tcp` protocol**

```Bash

grep ftp /etc/services | grep tcp

```

**Restrict to those that do not use the tcp protocol, while printing out the line number**

```Bash

grep -n ftp /etc/services | grep -v tcp

# -n, --line-number
# Prefix each line of output with the 1-based line number within its input file
# ( Notice that this argument is used with the source file, not after the pipe | )

# -v, --invert-match
# Invert the sense of matching, to select non-matching lines

```

**Get all strings that start with `ts` or end with `st`**

```Bash

grep 'ˆts' /etc/services # ^ to indicate start of a string
grep 'st$' /etc/services # $ to indicate end of a string

```
