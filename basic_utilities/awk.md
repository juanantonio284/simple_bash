# awk

## Introduction

`awk` is a pattern scanning and processing language/utility **used to extract and then print
specific contents of a file** and is often used to construct reports `awk` was created at Bell Labs
in the 1970s and derived its name from the last names of its authors: 
**Aho**, **Weinberger**, **Kernighan**.

* `awk` is used to manipulate data files, retrieving, and processing text
* `awk` works well with fields (containing a single piece of data, essentially a column) and records
  (a collection of fields, essentially a line in a file)
* `awk 'command' file` is used to specify a command directly at the command line
* `awk -f scriptfile file` is used to specify a file that contains the script to be executed

An input file is read one line at a time, and, for each line, `awk` matches the given pattern in the
given order and performs the requested action. 


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Examples

**Look at passwd file**

* The `passwd` command changes passwords for user accounts. 

* `/etc/passwd` is "the password file" and contains one line for each user account, with seven
  fields delimited by colons (`:`). 
  
  - These fields are: `login name`, `optional encrypted password`, `numerical user ID`, 
    `numerical group ID`, `user name or comment field`, `user home directory`, 
    `optional user command interpreter`. 
    For more information, consult the manual page `$ man 5 passwd`, or [this website][link_1]

``` Bash

# USING awk FOR A QUICK LOOK AT A FILE
awk 'NR < 10' /etc/passwd 

# 'NR < 10' means number of records less than 10 (this is using awk to view 10 lines of the file)
# (you could also have used head -10 /etc/passwd)

# passwd is a text file in the etc folder 
# ("/etc/passwd" describes the full path—it is at the system level)
                          
```
```

root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin

``` 

### Simple Examples 1

```Bash

# An input file is read one line at a time, and, for each line, `awk` matches the given pattern in
# the given order and performs the requested action.

awk '{ print $0 }' /etc/passwd        # Print entire file
awk -F: '{ print $1 }' /etc/passwd    # Print first field (column) of every line, separated by space
awk -F: '{ print $1 $7 }' /etc/passwd # Print first and seventh field of every line

# -F sets the field separator (FS) to a given value, in this case the symbol ':'.
# (the `/etc/passwd` file uses ':' to separate the fields)

```
<!-- separated by space??? -->


### Simple Examples 2

```Bash

# If a file has fields separated by spaces or tabs, you don't need to set the -F option because, by
# default, awk treats spaces or tabs as separators or delimiters.

awk '{ print $1, $2 }' file.txt # print first and second fields
                                # the comma is needed to put a space between the results

awk '{ print $1, $NF }' file.txt # NF means "number of fields" and selects the last field in the line.

awk -F, '{ print $1 }' test.csv     # for a CSV, set a comma ',' as separator
awk -F',' '{ print $1 }' test.csv   # this also works and is likely useful for some compound separator

```

### Compound Example 1

**Insert labels in a result**

``` Bash

# Insert the labels "name" and "shell" before selected fields
awk -F: '{ print "name: " $1 "    shell: " $7 }' /etc/passwd | head -10 

# The command passed to awk (i.e. the part after -F:) is surrounded with single quotes ''
#   * the first expression is "name: " followed by a $1 to select the first field, e.g. 'root'
#     or 'daemon'
#   * the second expression is "    shell: " followed by a $7 to select the seventh field,
#     e.g. /bin/bash

# -F sets the field separator, FS, to a given value, in this case the symbol ':'.
# (the `/etc/passwd` file uses ':' to separate the fields)

```
```

name: root    shell: /bin/bash
name: daemon    shell: /usr/sbin/nologin
name: bin    shell: /usr/sbin/nologin
name: sys    shell: /usr/sbin/nologin
name: sync    shell: /bin/sync
name: games    shell: /usr/sbin/nologin
name: man    shell: /usr/sbin/nologin
name: lp    shell: /usr/sbin/nologin
name: mail    shell: /usr/sbin/nologin
name: news    shell: /usr/sbin/nologin

```

### Compound Example 2

**Parsing files with `awk` (and `sort` and `uniq`)**

```Bash

# Generate a column containing a unique list of all the shells used for users in `/etc/passwd`
awk -F: '{ print $7 }' /etc/passwd | sort -u  # the field in `/etc/passwd` that holds the shell is #7
awk -F: '{ print $7 }' /etc/passwd | sort | uniq  # a different option

# /bin/bash
# /bin/sync
# /sbin/halt
# /sbin/nologin
# /sbin/shutdown

```

### Compound Example 3

**Using `grep` with `awk`**

```Bash

# Look for a value in a line, print a selected field
grep -i "sweden" test.csv | awk -F, '{ print $1 }' 

# use grep (global regular expression print), case insensitive (-i), to look for lines
# containing "sweden" in a CSV file
# use awk (with comma ',' as a field separator) to print the first field of each line

# In this particular csv file, the 1st field is the line number
# "6"
# "14"
# ...

```

### Compound Example 4

```Bash

# Look for a value in a line, print a selected field, add labels before the field
grep -i "finland" test.csv | awk -F, '{ print "Line number: " $1 "    Year: " $3 }' 
# use grep (global regular expression print), case insensitive (-i), to look for lines
# containing "finland" in a CSV file
# use awk (with comma ',' as a field separator) to print fields 1 and 3 of each line

# In this particular csv file, the 1st field is the line number, the 3rd is the year
# Line number: "1"    Year: "1980"
# Line number: "9"    Year: "1981"

```

[link_1]: https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/
