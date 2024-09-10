# `shred`

Overwrite a file to hide its contents, and optionally delete it.

```Bash

shred -zvu file_to_delete
# -z, --zero     adds a final overwrite with zeros to hide shredding
# -v, --verbose  enables display of operation progress
# -u             deallocate and remove file after overwriting

```
