# Look at your command history 

Open the `~/.bash_history` file in a text editor

```Bash

subl -n ~/.bash_history # i
open ~/.bash_history    # ii
#  i: opens in a new window of sublime text, if you have it installed
# ii: opens the file in default program (should be a text editor)

```

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
# The `history` command

Running the command `history` by itself shows the contents of the `~/.bash_history` file; but do not
confuse this with *opening* the file. `history` is a command which calls the utility *GNU History
Library*. 

*GNU History library* is able to keep track of commands entered in the shell, associate arbitrary
data with each line, and utilize information from previous lines in composing new ones. It has many
options and it's worth to look at `man history` every once in a while.

## Usage example

1. View the history through the `less` utility

```Bash

history | less
# Redirect output of history to the less utility. 
# This allows using the features of less to make it easier to read the history.

```

2. Quickly view the history in the shell

```Console
$ history

1  cd /
2  ls
3  cd
4  pwd
5  echo $SHELL
6  ls /var/
7  ls /usr/bin
8  ls /usr/local/bin
9  man fstab
10  ls
```

### Re-run a previous command

Using the example above:

* To re-run the `man` command you could type `!9`
* If this was the only `man` command in the history, you could also type `!man`
* If there were several `man` commands in the history, you could use `CTRL+R` to search backwards

#### Use `Ctrl+R` to search for a previously used command

* `Ctrl+R`: search for a command matching the characters you provide
    - Press this shortcut and start typing to search, keep pressing to move along options
* `Ctrl+G`: Leave history searching mode without running a command
* `Esc`: put the command in the prompt so you can edit it
* `Enter`: Run a command you found with Ctrl+R
