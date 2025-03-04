# simple_bash
Notes on some basic utilities for the shell

<!-- ## Single files -->

* `1_bash_command_list.md`: a list of common BASH commands with short descriptions 

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Folders

### miscellaneous

* `basic_utilities` contains tutorials on the following BASH utilities: `awk` `grep`, `sed`, `cat`,
  `shred`
  
* `other_utilities` contains notes on: `find`, `nano`, `gs`(ghostscript), `gpg` (GNU privacy guard)

### `guides`

* `list_directory_contents.md`: using the `ls` command to list directory contents and using the
  `sed` command to improve readability of the output

* `regex_1.md`: basic theory on regular expressions and a table listing operators for creating the
  most common expressions

* `run_custom_shell_scripts.md`: a tutorial on how to create and prepare a script so that it runs as
  a command in the shell

* `using_the_bash_history.md`: basic usage of the bash history

### `linux_package_mgmt`

* `apt_1_basics.md`: a basic tutorial on the `apt` utility for common tasks like installing,
  uninstalling, and updating

* `apt_example_installing_R.md`: a guide on how to install R[^note_1] 

[^note_1]: (There's not much to learn about `apt`, to be fair, but it's a practical example of
installing a program from start to finish. And, considering all the little tricks involved, such an
example might actually be useful.)

* `theory.md`: basic package management in Linux (how programs are installed)

* `upgrade_os.md`: notes on an operating system update

### `my_shell_scripts`

* `count_files`: count the files in a folder

* `create_files`: create files given a file prefix/suffix, an extension, and the desired number
  of files to create

* `remember`: write things to a "notepad"

* `remindme`: read the notes made with `remember`

* `template_simple_file_opener`: open commonly used files with a single command on the
  terminal

* `shrinkpdf`: a simple wrapper around Ghostscript to reduce the file size of PDFs; written by
  Alfred Klomp. [See usage instructions here][shrinkpdf_link]!!

* `splitpdf`: a simple wrapper around Ghostscript to extract pages from a PDF file; original by
  Westley Weimer

[shrinkpdf_link]: https://github.com/aklomp/shrinkpdf
