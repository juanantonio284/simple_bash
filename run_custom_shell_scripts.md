# Preparing Your Computer To Run Custom Shell Scripts

## Preliminaries

### The PATH variable

The directories where bash will search for standard commands are stored in an environment variable
called PATH. 

**Printing the current PATH environment variable**

```Bash

echo $PATH

# /home/user_name/.local/:/home/user_name/gems/bin:/home/user_name/anaconda3/bin:
# /home/user_name/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:
# /usr/games:/usr/local/games:/snap/bin:/snap/bin

```

The directories in this output are separated from one another by a colon (`:`). These are all the
directories that bash will check when you ask it to run a program or command. If your command is
not stored in any of these directories, bash cannot run it. 

If you move a script file to one of the directories listed by the `echo $PATH` command and the
command will run. (You can also add a directory where you would like bash to search for scripts.)

*Note for my computer*:

```

these seem like "normal" places to search

/home/user_name/.local/
/home/user_name/.local/bin
/usr/local/sbin
/usr/local/bin
/usr/sbin
/usr/bin
/sbin
/bin
/usr/games
/usr/local/games
/snap/bin
/snap/bin

these two correspond to things I installed, which modified my login script (see next section) so
that it adds these paths to the search

/home/user_name/gems/bin
/home/user_name/anaconda3/bin

```

### The `which` command

Note that bash will check these directories in the order they appear in the PATH variable. This
order is important because it may make a difference if you have two commands of the same name in
two directories in your PATH variable. 

If you're having trouble finding a particular command, you can use the `which` command with the name
of that command to see its path:

```Bash

# Using which to find the path of a command

which touch
# /usr/bin/touch

which echo
# /usr/bin/echo

# (/usr/bin is a directory right at the computer level, before you get to /home/user_name)

```

`which` is a useful tool for debugging a broken or weird PATH.


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Configuring Your Login Script

You can configure your PATH variable so that your custom scripts are automatically callable, just
like any other command, when you start a new command shell. 

When you open a command shell, the first thing it does is read a login script in your home
directory (`/Users/<username>` for Mac or `/home/<username>` for Linux) and execute any custom
commands it finds there. 

The login script will be `.login`, `.profile`, `.bashrc`, or `.bash_profile`, depending on your
system.

One way to find out which of these files is the login script on your system is to open each file and
add a line like the following:  
`echo this is the .bashrc login script`. Then open a terminal and you will see a line at the top
that displays the text you entered (thus letting you know which login script is loaded in your
system).

*Note for my computer*:

Could not find `~/.login`, `~/.bash_profile` or `~/.bash_login`.

Found these two, with the attached notes:

```

~/.profile: executed by the command interpreter for login shells. This file is not read by bash
(1), if ~/.bash_profile or ~/.bash_login exists.

~/.bashrc: executed by bash(1) for non-login shells. see /usr/share/doc/bash/examples/startup-files
(in the package bash-doc) for examples

```

(Excursus: [the difference between a login shell and a non-login shell][stack_login_shell]) 

### Adding a path to your scripts directory

You can alter the login script so it configures your PATH variable with other directories. For
example, the login script might have a line like  
`export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting`

This assigns a new value to PATH that allows the local RVM installation[^note_ruby] to manage any
installed Ruby versions. The `.bashrc` file sets the customized PATH every time a new command shell
is opened and your system will add this path to its search list when looking for commands.

You can implement a similar customization to make your shell scripts available by default: 

1. create a directory to save all your shell scripts in

2. add this directory to PATH in your login file to reference your new scripts more easily. To do
this, open the login script file in your text editor and add the line below to the top of the
file:

```Bash

export PATH="/path/to/scripts/:$PATH"

# note the syntax:
# * the quote (") opens, then the path follows, then instead of a closing quote there is :$PATH and
#   then the quote closes 
# * the path ends in /

export PATH="~/Development/simple_bash/my_shell_scripts/:$PATH"

```

Once this is done, any of the scripts you save in the development folder can then be called as a
command in the shell.


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Test Script

This script will print `Hello World` followed by the file path of the `neqn` shell script, a shell
script that should be in your bash files by default. Then it will use this path to print the
contents of `neqn` to the screen[^note_neqn]. 

Open a text editor and enter the code below:

```Bash

#!/bin/bash
echo "Hello World"
echo $(which neqn) # (ii)
cat $(which neqn) 

# (ii) uses which to find the location of the bash file neqn and then uses the echo command to print
# the location to the screen.

```

Save the script to your development directory and name it `intro`. Shell scripts don't need a
special file extension, so leave the extension blank (you can add the extension `.sh` if you
prefer, but this isn't required). 

To run code where one command is provided as an argument to another, bash uses a subshell to run the
second command and store the output for use by the first command. Here, the subshell runs the
`which` command, which returns the full path to the `neqn` script. This path is then used as the
argument for `echo`, and `echo` prints the path on the screen. (The third line works similarly.)

The first line in the file is called the *shebang*. The shebang allows you to define which program
will be run to interpret the script. Here we set the file as a bash file. You may have seen other
shebangs, like those for the Perl language (`#!/usr/bin/perl`) or for Ruby(`#!/usr/bin/env ruby`).

But, even with this new line added at the top, you still need to **change the file permissions of
the script to allow execution so you can execute the shell script as if it were a program**:

```Bash

chmod +x ~/Development/simple_bash/my_shell_scripts/intro
# change mode of file to "executable" with the +x argument

```




[^note_ruby]: Ruby version manager

[^note_neqn]: The contents of `neqn` aren't important at the moment; this is just being used as an
example script.

[stack_login_shell]: https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell