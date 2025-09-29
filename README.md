# simple_bash
Notes on some basic utilities for the shell

<!-- ## Single files -->

* `1_bash_command_list.md`: a list of common BASH commands with short descriptions 

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Folders

### miscellaneous

* `basic_utilities` contains tutorials on the following BASH utilities: 
  `awk`, `cat`, `grep`, `history`, `sed`, `shred`
  
* `other_utilities` contains notes on: 
  `find`, `gs` (ghostscript), `gpg`, `nano`, `diff`

### `guides`

* `create_directory_with_given_structure.md`: given `directory_1`, find out which folders are inside
  it. Then, create `directory_2` and, inside it, create empty folders with same names and structure
  as those of `directory_1`. (Uses the `tree` and `xargs` utilities.)

* `list_directory_contents.md`: using the `ls` command to list directory contents and using the
  `sed` command to improve readability of the output

* `regex_1.md`: basic theory on regular expressions and a table listing operators for creating the
  most common expressions

* `run_custom_shell_scripts.md`: a tutorial on how to create and prepare a script so that it runs as
  a command in the shell

* `using_yt-dlp`: using the `yt-dlp` command-line utility to download video and audio from youtube

### `guides_rare`

* `configuring_github_authentication.md`: detailed and practical instructions on how to configure
  ssh keys with github (better organized and summarized than the official gh reference)

* `github_pages_and_jekyll_themes`

### `linux_package_mgmt`

* `apt_1_basics.md`: a basic tutorial on the `apt` utility for common tasks like installing,
  uninstalling, updating, and reinstalling (managing the `sources` directory to edit the information
  stored about the repositories where apt searches for packages)

* `apt_example_installing_R.md`: a guide on how to install R[^note_1] 

* `theory.md`: basic package management in Linux (how programs are installed)

* `upgrade_os.md`: notes on how to update the operating system

* `snap_on_ubuntu.md`: notes on how snaps work on ubuntu and trying to fix a problem ...

[^note_1]: (There's not much to learn about `apt`, to be fair, but it's a practical example of
installing a program from start to finish. And, considering all the little tricks involved, such an
example might actually be useful.)

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
