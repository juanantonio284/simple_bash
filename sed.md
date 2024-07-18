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
sed s/pig/cow/ file > newfile
sed s/pig/cow/ < file > newfile
cat file | sed s/pig/cow/ > newfile

# substitute ALL instances of pig to cow
sed s/pig/cow/g file > newfile

# s stands for "substitute"
# g stands for "global"

```

### Delimiting Characters

In the previous example, he `/` characters are used to delimit the new and old strings. You can
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

```


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
 
`-i is the same as --in-place, edit files in place (save)`

**Caution:**

You must use the `-i` option with care, because the action is not reversible. It is always safer to
use sed without the `-i` option and then replace the file yourself (i.e. 
`$ sed s/pattern/replace_string/g file1 > file2` )

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
