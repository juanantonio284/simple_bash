# cat

Concatenate files and print on the standard output

### 1. Create a file

```Bash

cd path/to/folder

cat > file_1.txt
# cursor moves to line below where you can type the following:
THIS IS FILE 1, LINE 1
THIS IS FILE 1, LINE 2
# [press return key]
# [press `ctrl + d` to exit, but first:]

cat > file_2.txt
# cursor moves to line below where you can type the following:
THIS IS FILE 2, LINE 1

```

**A nicer method**

```Bash

cd path/to/folder

cat > file.txt << EOF

```

Another way to create a file at the terminal is `cat > file.txt << EOF`. A new file is created and
you can type the required input. To exit, enter `EOF` at the beginning of a line. `EOF` stands
for "end of file". Note that `EOF` is case sensitive (you could also use another word, such as
`STOP`). The delimiter must be a single word that does not contain spaces or tabs.

[More detail][link_1]: in this case, you are still in the shell (the history saves everything that
you've typed as one single command). This is because the shell interprets the `<<` operator as an
instruction to read input until it finds a line containing the specified delimiter. All the input
lines up to the line containing the delimiter are then fed into the standard input of the
command. 

### 2. Display the contents of one or more files

```Bash

cat file_1.txt file_2.txt
# THIS IS FILE 1, LINE 1
# THIS IS FILE 1, LINE 2
# THIS IS FILE 2, LINE 1

cat -n file_1.txt file_2.txt # number all output lines
                             # option -b will number all nonempty output lines

cat /etc/os-release # displays contents of the /etc/os-release text file 

```

### 3. Send the contents of multiple files into another file

```Bash

cat file_1.txt file_2.txt > file_3.txt
cat file_3.txt # see the contents of test_3.txt
# THIS IS FILE 1, LINE 1
# THIS IS FILE 1, LINE 2
# THIS IS FILE 2, LINE 1

```

**"Merge"**

```Bash

cat ./* > merged_file.md # take content from all files in current directory and output to a file

```

### 4. Append file contents to another file

```Bash

cat test1.txt >> test3.txt # use a double >> sign to append the contents of one file onto another

```

### 5. Write text and append to existing file

```Bash

cat >> test1.txt
# cursor moves to line below where you can type the following:
This is another line

```

**In a script context**

```Bash

echo -e "\n" | cat >> file_1.txt # .... (i)
cat - >> file_1.txt              # .... (ii)

# i: insert a blank line before continuing to append text
# ii: the symbol - means read from standard input, >> means append to

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## References

* https://phoenixnap.com/kb/linux-cat-command
* https://superuser.com/questions/1003760/what-does-eof-do

[link_1]: https://superuser.com/questions/1003760/what-does-eof-do
