# `sed`

<!-- from official documentation -->

`sed` is a stream editor.  A stream editor is used to perform basic text transformations on an input
stream (a file or input from a pipeline). It is sed's ability to filter text in a pipeline which
particularly distinguishes it from other types of editors.

## Part 1

### Basic Example

Any of the following methods will change all **first instances** of the string `pig` with the string
`cow` for each line of file and put the results in `newfile`:

```Bash

# substitute only the first instance of pig to cow
# (s stands for "substitute")
sed s/pig/cow/ file > newfile
sed s/pig/cow/ < file > newfile
cat file | sed s/pig/cow/ > newfile

# substitute ALL instances of pig to cow
# (g stands for "global")
sed s/pig/cow/g file > newfile

```

See more on [the `s` Command][s_command] and [regexp with sed][regexp]

[s_command]: https://www.gnu.org/software/sed/manual/sed.html#The-_0022s_0022-Command

[regexp]: https://www.gnu.org/software/sed/manual/sed.html#Regexp-Addresses

### Delimiting Characters

In the previous example, the `/` characters are used to delimit the new and old strings. You can
choose to use another character, as in:

```Bash

sed s:pig:cow:g file > newfile

```

Some of the complications come in when you want to use special characters in the strings to be
searched for or inserted. For example, suppose you want to replace all back slashes with forward
slashes:

```Bash

sed s/'\\'/'\/'/g file > newfile

# in '\\', the first back slash is used to escape the second
# in '\/', the back slash is used to escape the forward slash

```

### Difference Between `" "` and `' '`

It is never a bad idea to put the strings in either single or double quotes, but BASH interprets
them differently: 

```Bash

# difference in BASH between double quotes and single quotes

# double quotes are expanded
echo "$HOME"
# /home/coop

# single quotes are not expanded
echo '$HOME'
# $HOME

```

### Multiple Substitutions

If you want to make multiple simultaneous substitutions, you need to use the `-e` option, as in:

```Bash

sed -e s/"pig"/"cow"/g -e s/"dog"/"cat"/g < file > newfile

```
and you can work directly on streams generated from commands, as in:

```Bash

echo hello | sed s/"hello"/"goodbye"/g
# goodbye

```

#### Example

If you have a lot of commands, you can put them in a file and apply with the `-f` option.

```

1. Prepare "scriptfile", the file which will provide the substitutions

* Type in this line: cat > scriptfile

* Type in the three lines below:
s/pig/cow/g
s/dog/cat/g
s/frog/toad/g

```

```Bash

# 2. Use the file with SED
sed -f scriptfile < file > newfile

# scriptfile is applied to file (the original which has the lines with pig, dog, frog, etc), this is
# outputed to a newfile

```

<!-- scriptfile didn't quite work, see link below as it might have some hints -->
<!-- https://unix.stackexchange.com/questions/95939/how-exactly-do-i-create-a-sed-script-and-use-it-to-edit-a-file -->

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Part 2

<!-- Content below from -->
<!-- Chapter 2. File and Text Manipulation Utilities / sed and awk [unit] -->

## `sed` command syntax

You can invoke `sed` using commands like those below
 
* `sed -e command <filename>`
    - specify editing commands **at the command line**, operate on file, and put the output on
      standard out (usually this is the terminal)

* `sed -f scriptfile <filename>`
    - specify editing commands **in a file** (named 'scriptfile' in this example), operate on file,
      and put the output on standard out
    
* `echo "I hate you" | sed s/hate/love/`
    - use sed to filter standard input, putting output on standard out

The `-e` option allows you to specify multiple editing commands simultaneously at the command line.
(It is unnecessary if you only have one operation invoked.)

## Basic Operations with `sed`

The table below explains some basic operations, where `pattern` is the current string and
`replace_string` is the new string:

|               **Command**                |                       **Usage**                       |
|:----------------------------------------:|:-----------------------------------------------------:|
|   `sed s/pattern/replace_string/ file`   |    Substitute first string occurrence in every line   |
|   `sed s/pattern/replace_string/g file`  |    Substitute all string occurrences in every line    |
| `sed 1,3s/pattern/replace_string/g file` | Substitute all string occurrences in a range of lines |
| `sed -i s/pattern/replace_string/g file `| Save changes for string substitution in the same file |
 
**Caution:**

`-i` stands for `--in-place`, edit files in place (save), **not** "case insensitive". You must use
the `-i` option with care, because the action is not reversible. 

It is always safer to use sed without the `-i` option and then replace the file yourself:

```Bash

sed s/pattern/replace_string/g file1 > file2

```

The above command will replace all occurrences of pattern with `replace_string` in `file1` and move
the contents to `file2`. The contents of `file2` can be viewed with `cat file2`. If you approve,
you can then overwrite the original file with `mv file2 file1`.

```Bash

# Example: convert 01 to JAN, 02 to FEB, 03 to MAR, etc

sed -e 's/01/JAN/' -e 's/02/FEB/' -e 's/03/MAR/' -e 's/04/APR/' -e 's/05/MAY/' \
    -e 's/06/JUN/' -e 's/07/JUL/' -e 's/08/AUG/' -e 's/09/SEP/' -e 's/10/OCT/' \
    -e 's/11/NOV/' -e 's/12/DEC/'

```

## Demo: using `sed`

```

Prepare "infile.txt", the file which will provide the stream that will be edited

1. Type in this line: cat > infile.txt

2. Type in the three lines below

This is the first line
This is the second line
This is the third line

3. Type ctrl + d

```

```Bash

cat infile.txt # see what's on the file

sed -e s/is/are/ infile.txt # substitutes first instance of 'is' with `are` in all lines
sed -e s/is/are/g infile.txt # substitutes all instances of 'is' with `are` in all lines
sed -e 1,2s/is/are/g infile.txt # in lines 1 and 2, substitute all instances of 'is' with `are` 
sed -e 1,2s/is/are/g infile.txt > outfile.txt # same as above sends to another file

# forward slash is not necessary, can also use : and other characters
sed -e 1,2s:is:are:g infile.txt # substitutes all instances of 'is' with `are` in lines 1,2 

```

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Part 3

### Basic Example

[Taken from Shotts, *The Linux Command Line* (Second Internet Edition)]

```Bash

# produce a one-word stream of text using echo and pipe it into sed.

echo "front" | sed 's/front/back/' # s is the command for substitution
echo "front" | sed 's_front_back_' # delimiter _ instead of /
echo "front" | sed '1s/front/back/' # address 1 causes the substitution to be performed on the first
                                    # line of input stream
echo "front" | sed '2s/front/back/' # this does not work since stream does not have a line 2

```

### `sed` address notation

Addresses may be expressed in many ways. Here are the most common:

|  **Address**  |                                 **Description**                                |
|:-------------:|:------------------------------------------------------------------------------:|
|      `n`      |                   A line number where `n` is a positive integer                |
|      `$`      |                                  The last line                                 |
|   `/regexp/`  |            Lines matching a POSIX basic regular expression[^note_1]            |
| `addr1,addr2` |            A range of lines from `addr1` to `addr2`, inclusive[^note_2]        |
|  `first~step` | Match the line represented by first, then each line at step intervals[^note_3] |
|   `addr1,+n`  |                      Match `addr1` and the following `n` lines                 |
|    `addr!`    |        Match all lines except `addr`, which may be any of the forms above      |


[^note_1]: Note that the regular expression is delimited by slash characters. Optionally, the
regular expression may be delimited by an alternate character, by specifying the expression with
`\cregexpc`, where `c` is the alternate character.

[^note_2]: Addresses may be any of the single address forms above.

[^note_3]: 'first' and 'step' are numbers. For example `1~2` refers to each odd numbered line, `5~5`
refers to the fifth line and every fifth line thereafter.

### `sed` basic editing commands

|       **Command**       |                   **Description**                                      |
|:-----------------------:|:----------------------------------------------------------------------:|
| `=`  |                                 Output current line number                                |
| `a`  |                             Append text after the current line                            |
| `d`  |                                  Delete the current line                                  |
| `i`  |                          Insert text in front of the current line                         |
| `p`  |                              Print the current line[^note_4]                              |
| `q`  | Exit sed without processing any more lines. If `-n` is not specified, output current line |
| `Q`  |                         Exit sed without processing any more lines                        |
| `s/regexp/replacement/` |      Find regexp and change to replacement[^note_5]                    |
| `y/set1/set2` | Transliteration (convert characters from set1 to characters in set2)[^note_6]    |


[^note_4]: By default, sed prints every line and only edits lines that match a specified address
within the file. The default behavior can be overridden by specifying the -n option.

[^note_5]: `replacement` may include the special character `&`, which is equivalent to the text
matched by regexp. In addition, `replacement` may include the sequences `\1` through `\9`, which
are the contents of the corresponding subexpressions in regexp. 
<!-- For more about this, see the discussion of back references below. After the trailing slash following replacement, an optional flag may be specified to modify the s command’s behavior. -->

[^note_6]: Note that unlike `tr`, `sed` requires that both sets be of the same length.


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Part 4

### Preliminaries

1. Create file with text to substitute

```Bash
cd path/to/directory/
cat > file_1.txt

# enter text below (including blank line after line of text)
a
a
a line of text
another line of text

# Ctrl + D to exit
```

2. Create a script-file named `script.sed` with sed commands

```Bash
s/line/string/g
s@a@b@g
# The @ was used instead of / to remind you that it's possible to use any character to separate the
# fields, which will be useful for when you're searching for "/".
# Notice that there are no single or double quotes around the regex or the substitution.
```

### Example 1

1. Run `sed` command with `debug` to trace what happens

```Bash
sed --debug s/'a'/'b'/ file_1.txt
```

2. See output

```
SED PROGRAM:
  s/a/b/

INPUT:   'file_1.txt' line 1
PATTERN: a
COMMAND: s/a/b/
MATCHED REGEX REGISTERS
  regex[0] = 0-1 'a'
PATTERN: b
END-OF-CYCLE:
b


INPUT:   'file_1.txt' line 2
PATTERN: a
COMMAND: s/a/b/
MATCHED REGEX REGISTERS
  regex[0] = 0-1 'a'
PATTERN: b
END-OF-CYCLE:
b

INPUT:   'file_1.txt' line 3
PATTERN: a line of text
COMMAND: s/a/b/
MATCHED REGEX REGISTERS
  regex[0] = 0-1 'a'
PATTERN: b line of text
END-OF-CYCLE:
b line of text


INPUT:   'file_1.txt' line 4
PATTERN: another line of text
COMMAND: s/a/b/
MATCHED REGEX REGISTERS
  regex[0] = 0-1 'a'
PATTERN: bnother line of text
END-OF-CYCLE:
bnother line of text
```

### Example 2

<!-- https://www.gnu.org/software/sed/manual/sed.html#sed-scripts -->

1. Run `sed` command with the sed script

```Bash
sed -f script.sed file_1.txt > output.txt
# can also do: sed --debug -f script.sed file_1.txt
```
