# simple_bash
Notes on some basic utilities for the shell

## Single files

* `1_bash_command_list.md`: a list with short explanations of what each command is good for

* `bash_history_usage.md`: basic usage of the bash history

* `regex_1.md`: basic theory on regular expressions and a table listing operators to create the most
  common expressions

* `run_custom_shell_scripts.md`: a tutorial on how to create and prepare a script so that it runs as
  a command in the shell

## Folders

* `basic_utilities` contains tutorials on the following BASH utilities: `awk` `grep`, `sed`, `cat`,
  `shred`
  
* `other_utilities` contains notes on: `gs`(ghostscript), `gpg` (GNU privacy guard), `nano`, `find`
  
* `linux_package_mgmt` contains: 
    - `theory.md`, basic package management in Linux (how programs are installed)
    - `apt_1_basics.md`, a basic tutorial on the `apt` utility for common tasks like installing,
      uninstalling, and updating
    - `apt_example_installing_R.md`, a guide on how to install R[^note_1] 

[^note_1]: (There's not much to learn about `apt`, to be fair, but it's a practical example of
installing a program from start to finish. And, considering all the little tricks involved, such an
example might actually be useful.)

* `my_shell_scripts` contains: 
    - `count_files`: count the files in a folder
    - `remember`: write things to a "notepad"
    - `remindme`: to read the notes made with `remember`
    - `template_simple_file_opener`: to open commonly used files with a single command on the
      terminal
    - `shrinkpdf`: a simple wrapper around Ghostscript to reduce the file size of PDFs; written by
      Alfred Klomp. [See usage instructions here][shrinkpdf_link]!!

[shrinkpdf_link]: https://github.com/aklomp/shrinkpdf
