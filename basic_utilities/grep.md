# `grep`

<!-- Content below from -->
<!-- Chapter 1. Essential Command Line Tools, Lesson 4: Finding strings: `grep` -->
`grep` stands for "`global regular expression print`", which points out that it can do more than
match simple strings. It can work with more complicated regular expressions which can contain
wildcards and other special attributes.

<!-- from official documentation -->
Given one or more patterns, **grep searches input files for matches to the patterns**. When it finds
a match in a line, it copies the line to standard output (by default)—i.e. it prints each line that
matches a pattern. Though grep expects to do the matching on text, it has no limits on input line
length other than available memory, and it can match arbitrary characters within a line.
(Since newline is also a separator for the list of patterns, there is no way to match newline
characters in a text.)

[(See documentation here)][grep_doc]

[grep_doc]: https://www.gnu.org/software/grep/manual/


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## `grep` options

|  **Option**  |                                  **Meaning**                                  |
|:------------:|:-----------------------------------------------------------------------------:|
|     `-i`     |                                  ignore case                                  |
|     `-e`     |                      search for the following expression                      |
|     `-v`     |                                  invert match                                 |
|     `-n`     |                               print line number                               |
|     `-H`     |                                 print filename                                |
|     `-a`     |                           treat binary files as text                          |
|     `-I`     |                              ignore binary files                              |
|     `-r`     |                         recurse through subdirectories                        |
|     `-l`     |               print out names of all files that contain matches               |
|     `-L`     |            print out names of all files that do not contain matches           |
|     `-c`     |                    print out number of matching lines only                    |

**Note**: 

`-e PATTERNS` (or `--regexp=PATTERNS`)

* If these options are used multiple times, or are combined with the  `-f` (`--file`)  option,
  `grep` searches for all patterns given
* These options can be used to protect a pattern beginning with "`-`"
* "PATTERNS" shows where the search pattern should be placed

### Common Combinations
<!-- Content below from -->
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


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Sample Usage

### Simple Examples

```Bash

# Simplest example
grep pig file
# finds three instances of the string "pig" in file: "pig", "dirty pig", and "pig food"

# More examples
grep "^dog" file # print all lines that start with "dog"
grep "dog$" file # print all lines that end with "dog"
grep d[a-p] file # print all lines with a d followed by a character from a to p

```

### Piping Output and Using Options

```Bash

ps | grep TTY # The ps command lists the processes on the system, grep filters out a specific line

ps | grep -i tty # grep is case sensitive by default. Ignore the case with -i or --ignore-case

grep -i -e pig -e dog -r
# will search all files in the current directory and those below it (`-r`) for the strings
# (`-e`) "pig" or "dog", ignoring case (`-i`). [see meaning of flags in next section]

# Pairing `grep` with the `strings` command
strings book1.xls | grep my_string # search for the string `my_string` in a spreadsheet
# the `strings` command is used to extract all printable character strings found in the file or
# files given as arguments. It is useful in locating human-readable content embedded in binary
# files (for text files one can just use grep).

```

**Using Regular Expressions**

```Bash

cd path/to/directory
git log | grep Author | grep -oP '(?<=Author: ).*' | sort -u | tr -d '<>'

```

The command above will: 

* use `grep` to search for any lines that start with the word 'Author'
* pipe the results to another `grep` command to filter anything after the word 'Author' and print
  only the words that matched (leaves the commit author's name and email.)
    - `-o, --only-matching   print only the matched pattern`
    - `-P, --perl-regexp    Interpret pattern as Perl-compatible regular expressions (PCREs)`
* `sort` the list and use the -u option to remove any duplicated lines
* since the email is surrounded by the characters `<>` by default, we trim these characters by using
  `tr -d '<>'`


### More Examples
  
```Bash

# cd to directory where log file is
cd path/to/directory
# Download file from https://github.com/dolevf/Black-Hat-Bash/blob/master/ch02/log.txt

# extract any lines containing the IP address 35.237.4.214
grep "35.237.4.214" log.txt

# the backslash pipe \| acts as an OR condition
grep "35.237.4.214\|13.66.139.0" log.txt

# instead of \|, you can use -e or --regexp to include various patterns
grep -e "35.237.4.214" -e "13.66.139.0" log.txt

# EXCLUDE lines containing a certain pattern—i.e. invert the match—with -v or --invert-match
grep -v "35.237.4.214" log.txt

# print only the matched pattern, and not the entire line where the pattern was found, with -o
# or --only-matching
grep -o "35.237.4.214" log.txt

```

### Even More Examples
<!-- Content below from -->
<!-- Chapter 1. Essential Command Line Tools, Lab 1.2. Using 'grep' -->

```Bash

# Get all strings that start with `ts` or end with `st`
grep 'ˆts' /etc/services # ^ to indicate start of a string
grep 'st$' /etc/services # $ to indicate end of a string

# Find all entries in the `/etc/services` file that include the string "`ftp`"
grep ftp /etc/services

# Restrict to those that use the `tcp` protocol
grep ftp /etc/services | grep tcp

# Restrict to those that do not use the tcp protocol, while printing out the line number
grep -n ftp /etc/services | grep -v tcp
# -n, --line-number
#     Prefix each line of output with the 1-based line number within its input file
#     Notice that this argument is used with the source file, not after the pipe |
#
# -v, --invert-match
#     Invert the sense of matching, to select non-matching lines

```
