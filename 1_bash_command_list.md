# BASH Command List

## awk

(Aho, Weinberger, Kernighan)

`awk` is a pattern scanning and processing language/utility **used to extract and then print
specific contents of a file** and is often used to construct reports.

* `awk` is used to manipulate data files, retrieving, and processing text
  - an input file is read one line at a time, and, for each line, `awk` matches the given pattern in
    the given order and performs the requested action
* `awk` works well with fields and records
  - a field contains a single piece of data (essentially a column)
  - records are a collection of fields (essentially a line in a file)
  
`awk` was created at Bell Labs in the 1970s and derived its name from the last names of its
authors: **Aho**, **Weinberger**, **Kernighan**.


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## cat

(Con**cat**enate files and print on the standard output)

Common uses: 

* Create a file
* Display the contents of one or more files
* Send the contents of multiple files into another file (can be used to "merge" files)
* Append file contents to another file
* Write text and append to existing file
* Read from standard input in a script context


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## find

Find files and directories

## gs

(ghostscript)

Common uses:

* Combine various PDF files into one single file

## gpg 

(GNU Privacy Guard)

Encrypt files

## grep

(global regular expression print)

Given one or more patterns, **grep searches input files for matches to the patterns**. When it finds
a match in a line, it copies the line to standard output (by default)—i.e. it prints each line that
matches a pattern. 

## history

Running the command `history` by itself shows the contents of the `~/.bash_history` file; but do not
confuse this with *opening* the file. `history` is a command which calls the utility *GNU History
Library*. (See the `history.md` file.)

## ls

List directory contents; powerful when combined with `sed` (see the `list_directory_contents.md`
file).

## nano

text editor that runs from the terminal

## sed

(stream editor)

`sed` is a stream editor used to perform basic text transformations on an input stream (a file or
input from a pipeline). It is sed's ability to filter text in a pipeline which particularly
distinguishes it from other types of editors.

## shred

overwrite a file to hide its contents, and optionally delete it

## tree, xargs

* `tree`: list contents of directories in a tree-like format
* `xargs`:  build and execute command lines from standard input

Use these in tandem to duplicate a directory's structure (create a new, empty, directory with the 
same inner folders, also empty, as the first one): 
`tree -dfi --noreport | xargs -I{} mkdir -p "$HOME/path/to/directory_2/{}"`

(See `create_directory_with_given_structure.md` file)

## yt-dlp

command-line utility to download video and audio from youtube

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
