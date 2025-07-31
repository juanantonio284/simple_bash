# How To Run Custom Shell Scripts

## TLDR

**1. Open the login script file (e.g. `.bashrc`) and add a path to your scripts directory**  
(This only needs to be done once, when you first create a scripts directory; you may skip this step
in the future)

* Open the `.bashrc` file in a text editor 

    ```Bash
    
    subl -n ~/.bashrc # (make sure .bashrc is the correct login script file for your system)
    
    ```

* Add the line below to the top of the file (**do not** run this in terminal)

    ```Bash
    
    export PATH="/path/to/scripts/:$PATH" 
    # note the syntax:
    # * the quote (") opens, then the path follows, then instead of a closing quote there is :$PATH, 
    #   and then the quote closes 
    # * the path ends in /
    
    ```

**2. Create a script that starts with the `shebang`**  
(This is a different file in the scripts directory.)

```Bash

#!/bin/bash

echo "Hello World"
# the name of this script would be "helloworld" (.sh extension is optional)

```

**3. Change mode of file to "executable" with the `+x` argument**

```Bash

chmod +x ~/path/to/scripts/helloworld
# this allows executing the shell script as if it were a program
# make sure script file has the shebang #!/bin/bash

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Preliminary Theory

### The `PATH` variable

The directories where bash will search for standard commands are stored in an environment variable
called `PATH`. 

```Bash

echo $PATH # this prints the current `PATH` environment variable

```

Printout to terminal window below:

```
/home/user_name/.local/:/home/user_name/gems/bin:/home/user_name/anaconda3/bin:
/home/user_name/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:
/usr/games:/usr/local/games:/snap/bin:/snap/bin
```
The directories in this output are separated from one another by a colon (`:`). These are all the
directories that bash will check when you ask it to run a program or command. If your command is
not stored in any of these directories, bash cannot run it. 

If you move a script file to one of the directories listed by the `echo $PATH` command the command
will run. (You can also add a directory where you would like bash to search for scripts.)

**Note**: below is the value of my `PATH` variable (what printed to the terminal window), separated
  by lines to understand better

```

These seem like "normal" places to search

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

These two correspond to programs I installed, which modified my login script (see next section) so
that it adds these paths to the search

/home/user_name/gems/bin
/home/user_name/anaconda3/bin

```

### The `which` command

Note that bash will check these directories in the order they appear in the `PATH` variable. This
order is important because it may make a difference if you have two commands of the same name in
two directories in your `PATH` variable. 

If you're having trouble finding a particular command, `which` is a useful tool for debugging a
broken or weird `PATH` variable: 

```Bash

# Using which to find the path of a command

which touch
# /usr/bin/touch

which echo
# /usr/bin/echo

# Note: /usr/bin is a directory right at the computer level, before you get to /home/user_name

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Configuring Your Login Script

You can configure your `PATH` variable so that your custom scripts are automatically callable, just
like any other command, when you start a new command shell. 

When you open a command shell, the first thing it does is read a login script in your home
directory (`/Users/<username>` for Mac or `/home/<username>` for Linux) and execute any custom
commands it finds there. 

The login script will be `.login`, `.profile`, `.bashrc`, or `.bash_profile`, depending on your
system.

One way to find out which of these files is the login script on your system is to open each file and
add a line like the following:  
`echo this is the .bashrc login script`; then open a terminal and you will see a line at the top
that displays the text you entered (thus letting you know which login script is loaded in your
system).

**Note**: in my computer, there were no `~/.login`, `~/.bash_profile` or `~/.bash_login` files.
  Found the two below, with those notes inside.

```

~/.profile: executed by the command interpreter for login shells. This file is not read by bash
(1), if ~/.bash_profile or ~/.bash_login exists.

~/.bashrc: executed by bash(1) for non-login shells. see /usr/share/doc/bash/examples/startup-files
(in the package bash-doc) for examples

```

(Excursus: [the difference between a login shell and a non-login shell][stack_login_shell]) 

### Adding a path to your scripts directory

You can alter the login script so it configures your `PATH` variable with other directories. 

For example, the login script might have a line like  `export PATH="$PATH:$HOME/.rvm/bin" # Add RVM
to PATH for scripting`. (This would assign a new value to `PATH` that allows the local RVM
installation[^note_ruby] to manage any installed Ruby versions.) 

The `.bashrc` file sets the customized `PATH` every time a new command shell
is opened and your system will add this path to its search list when looking for commands.

You can implement a similar customization to make your shell scripts available by default: 

1. Create a directory to save all your shell scripts in

2. Add this directory to `PATH` in your login file to reference your new scripts more easily. To do
this, **open the login script file in your text editor** and add the line below to the top of the
file:

```Console

DO NOT RUN LINE BELOW IN TERMINAL
open the login script file in your text editor and add the line below to the top of the file 

export PATH="/path/to/scripts/:$PATH"

note the syntax:
* the quote (") opens, then the path follows, then instead of a closing quote there is :$PATH and
 then the quote closes 
* the path ends in /

```

Once this is done, any of the scripts you save in the development folder can then be called as a
command in the shell.


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Preparing a script to run as a program

### Sample script

This script will print `Hello World` followed by the file path of the `neqn` shell script, a shell
script that should be in your bash files by default[^note_neqn]. Then it will use this path to
print the contents of `neqn` to the screen. Open a text editor and enter the code below:

```Bash

#!/bin/bash

echo "Hello World"
echo $(which neqn) # .... (i)
cat $(which neqn) 

# (i): which is used to find the location of the bash file neqn; then the echo command is used to
#      print the location to the screen

```

Save the script to your development directory and name it `intro`. Shell scripts don't need a
special file extension, so leave the extension blank (you can add the extension `.sh` if you
prefer, but this isn't required). 

To run code where one command is provided as an argument to another, bash uses a subshell to run the
second command and store the output for use by the first command. Here, the subshell runs the
`which` command, which returns the full path to the `neqn` script. This path is then used as the
argument for `echo`, and `echo` prints the path on the screen. (The third line works similarly.)

The first line in the example (`#!/bin/bash`) is called the **shebang** and it allows you to define
which program will be run to interpret the script.[^note_shebang] But, even with this new line
added at the top, you need to change the file permissions of the script to allow execution so you
can execute the shell script as if it were a program:

### Change file permissions

```Bash

chmod +x ~/Development/simple_bash/my_shell_scripts/intro
# change mode of file to "executable" with the +x argument
# this allows executing the shell script as if it were a program
# make sure script file has the shebang #!/bin/bash

```

**Run**: you can run the script by opening a terminal and typing `intro`.


### Debugging

**`-n`**

An easy way to check for errors early is by using the `-n` parameter when running a script:
`$ bash -n script.sh`

This parameter will read the commands in the script but won’t execute them, so any syntax errors
that exist will be shown onscreen. You can think of `-n` as a dry-run method to test the validity
of your syntax.

**`-x`**

You can also use the `-x` parameter to turn on verbose mode, which lets you see commands being
executed and will help you debug issues as the script executes in real time: `$ bash -x script.sh`

If you want to start debugging at a given point in the script, include the `set` command in the
script itself.

```Bash

#!/bin/bash
set -x
--snip--
set +x

```

You can think of set as a valve that turns a certain option on and off. In this example, the first
command sets the debugging mode (`set -x`), while the last command (`set +x`) disables it. By using
set, you can avoid generating a massive amount of noise in your terminal when your script is large
and contains a specific problem area.




<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->

[^note_ruby]: 
Ruby version manager

[^note_neqn]: 
The contents of `neqn` aren't important at the moment; this is just being used as an example
script.

[stack_login_shell]: https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell

[^note_shebang]: 
We generally set the file as a bash file but you may have seen other shebangs, like those for the
Perl language(`#!/usr/bin/perl`) or for Ruby (`#!/usr/bin/env ruby`).
