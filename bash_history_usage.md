# Bash history

## Search for a previously used command

* `Ctrl+R`: search for a command matching the characters you provide.
    - Press this shortcut and start typing to search, keep pressing to move along options
* `Ctrl+G`: Leave history searching mode without running a command.
* `Esc`: put the command in the prompt so you can edit it
* `Enter`: Run a command you found with Ctrl+R.


## Look at history 

**Open the history file**

```Bash

open ~/.bash_history # opens the file in default program (should be a text editor)
subl -n ~/.bash_history # opens in a new window of sublime text (if you have it installed)

```

**another option**

```Bash

history | less
# Redirect output of history to less command using a pipe to make it easier to scroll along each 
# line at a time.

```

## Delete command history in terminal

one option: 

```

history -c

```
another option: 
```

rm ~/.bash_history

```
