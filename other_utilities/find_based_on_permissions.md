# Finding Files Based on Permissions

`find` can locate files based on permissions.

Search for files and directories readable by everyone on a system (others, `o`), beginning from the root directory and searching recursively

## Readable and writeable (`r`, `w`)

```Bash

find / -perm -o=r
# /: beginning from root directory
# -perm : see use of -perm in separate section
# -o=r: others = readable

find / -type f -perm -o=r # -type f for files
find / -type d -perm -o=r # -type d for directories

find / -perm -o=w
# -o=r: others = writeable

```

Suppress any access-denied errors while searching by piping the standard error stream to `/dev/null`

```Bash

find / -perm -o=r 2> /dev/null
# is 2 a code for error stream?

```

## Executable (`x`)

Search for files and directories[^x_dir] that are executable by everyone

```Bash

find / -perm -o=x

find / -type f -perm -o=rwx # find all globally readable, writable, and executable files

```

[^x_dir]: 
An *executable directory*, a directory with a set executable permission (`x`), is one that allows
users to navigate into it (for example, with `cd`).

## Particular permissions

We could use this to search for files set with either SetUID or SetGID.


```Bash

# The following searches for SetGID files
find / -perm -4000 2> /dev/null

# Similarly, this command searches for SetUID files:
find / -perm -2000 2> /dev/null

# We can also locate directories set with the sticky bit flag:
find / -perm -1000 2> /dev/null

```

Searching for these special permissions will likely yield results on most Linux systems, as some
files have these permissions set by default. It's important to become familiar with these files so
you can easily distinguish between default system files and ones that were modified by the system
owner.


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Use of `perm` (permission argument)

[In the manual, the word 'mode' is underlined in the command and in the first description that
explains the command. Meaning that the value of the mode field can change and the first symbol
before this field (`-`, `/`, ` `) tells the command what mode to get in.]

`-perm -mode`: all of the permission bits *mode* are set for the file
 
* Symbolic modes are accepted in this form, and this is usually the way in which you would want to
  use them

    - You must specify `u`, `g` or `o` if you use a symbolic mode

————————————

`-perm /mode`: any of the permission bits *mode* are set for the file

* Symbolic modes are accepted in this form

    - You must specify `u`, `g` or `o` if you use a symbolic mode
    
    - If no permission bits in mode are set, this test matches any file (to be consistent with the
      behaviour of `-perm -000`)

————————————

`-perm mode`: file's permission bits are exactly *mode* (octal or symbolic)

* Since an exact match is required, if you want to use this form for symbolic modes, you may have to
  specify a rather complex mode string

    - For example `-perm g=w` will only match files which have mode `0020` (that is, ones for which
      group write permission is the only permission set)

    - It is more likely that you will want to use the `/` or `-` forms, for example `-perm -g=w`,
      which matches any file with group write permission

