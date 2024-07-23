# awk

## `awk` (Aho, Weinberger, Kernighan)

`awk` is a pattern scanning and processing language/utility used to extract and then print specific
contents of a file and is often used to construct reports.[^note_1]

[^note_1]: `awk` was created at Bell Labs in the 1970s and derived its name from the last names of
its authors: Aho, Weinberger, Kernighan.

`awk`:

* is used to manipulate data files, retrieving, and processing text
* works well with fields (containing a single piece of data, essentially a column) and records
  (a collection of fields, essentially a line in a file)
* `awk 'command' file` is used to specify a command directly at the command line
* `awk -f scriptfile file` is used to specify a file that contains the script to be executed


**Example**

``` Bash

head -10 /etc/passwd

# this is the output of the command above [without the #]
# root:x:0:0:root:/root:/bin/bash
# daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
# bin:x:2:2:bin:/bin:/usr/sbin/nologin
# sys:x:3:3:sys:/dev:/usr/sbin/nologin
# sync:x:4:65534:sync:/bin:/bin/sync
# games:x:5:60:games:/usr/games:/usr/sbin/nologin
# man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
# lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
# mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
# news:x:9:9:news:/var/spool/news:/usr/sbin/nologin

``` 

``` Bash

awk -F: '{print "name: " $1 "    shell: " $7}' /etc/passwd | head -10 

# -F sets the field separator, FS, to a given value, in this case the symbol ':'
# In this example, the `/etc/passwd` file uses "`:`" to separate the fields, so `-F:` is used

# The command passed to awk needs to be surrounded with apostrophes (aka single-quote '). 
# * the first expression is "name: " followed by a $1 (the first field, e.g. 'root' or 'daemon')
# * the second expression is "    shell: " followed by a $7 (the seventh field, e.g. /bin/bash)

# this is the output of the command above (without the #) ..........................................
# name: root    shell: /bin/bash
# name: daemon    shell: /usr/sbin/nologin
# name: bin    shell: /usr/sbin/nologin
# name: sys    shell: /usr/sbin/nologin
# name: sync    shell: /bin/sync
# name: games    shell: /usr/sbin/nologin
# name: man    shell: /usr/sbin/nologin
# name: lp    shell: /usr/sbin/nologin
# name: mail    shell: /usr/sbin/nologin
# name: news    shell: /usr/sbin/nologin

```


## `awk` basic operations

The input file is read one line at a time, and, for each line, `awk` matches the given pattern in
the given order and performs the requested action. 

The `-F` option allows you to specify a particular field separator character. For example, the
`/etc/passwd` file uses "`:`" to separate the fields, so the `-F:` option is used with that file.

The command passed to awk needs to be surrounded with apostrophes (aka single-quote `'`). 

The table explains the basic tasks that can be performed using `awk`. 

```Bash

awk '{ print $0 }' /etc/passwd       # Print entire file
awk -F: '{ print $1 }' /etc/passwd   # Print first field (column) of every line, separated by space
awk -F: '{ print $1 $7 }' /etc/passwd # Print first and seventh field of every line

```


## Exercise

**Parsing files with `awk` (and `sort` and `uniq`)**

```Bash

# Generate a column containing a unique list of all the shells used for users in `/etc/passwd`

awk -F: '{print $7}' /etc/passwd | sort -u  # the field in `/etc/passwd` that holds the shell is #7

awk -F: '{print $7}' /etc/passwd | sort | uniq  # another option

# /bin/bash
# /bin/sync
# /sbin/halt
# /sbin/nologin
# /sbin/shutdown

```

**Additional info**

This exercise requires some knowledge of `/etc/passwd`. You may need to consult the manual page 
`$ man 5 passwd`, or[this website][link_1]

The `passwd` command changes passwords for user accounts. `/etc/passwd` is "the password file" and
contains one line for each user account, with seven fields delimited by colons (`:`). These fields
are: `login name`, `optional encrypted password`, `numerical user ID`, `numerical group ID`, 
`user name or comment field`, `user home directory`, `optional user command interpreter`.

[link_1]: https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/
