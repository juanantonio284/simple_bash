# Snap Problem

On Ubuntu 24.04.2 LTS

## 1. Fuckery is afoot

Using the `du` utility (`sudo du --max-depth=1 -hx /`), I found that `/var` was one of the folders
using the most storage. 

```
24G  /var
4.0K  /lib.usr-is-merged
208M  /boot
50M /root
168K  /snap
25M /etc
17G /usr
8.0K  /media
12K /mnt
4.0K  /srv
384K  /tmp
16K /lost+found
126G  /home
4.0K  /cdrom
4.0K  /sbin.usr-is-merged
4.0K  /bin.usr-is-merged
1.5G  /opt
296G  /
```

Kept going and saw that it is the snaps folder (`/var/lib/snapd/snaps`) that uses the most data. 

Inside the folder, there seem to be old versions of programs and "system snaps" that have not been
cleaned: `kf6-core22_42.snap, kf6-core22_43.snap, kf6-core24_27.snap, kf6-core24_22.snap,
gnome-42-2204_202.snap, gnome-42-2204_176.snap, gnome-46-2404_90.snap, gnome-3-38-2004_143.snap,
gnome-3-38-2004_140.snap, firefox_6259.snap, firefox_6227.snap, etc`

### Notes

**1**

There is a different folder `~/snap` that seems to be in use and updated; it contains folders and
subfolders but, ultimately, almost everything is empty (and says 0 bytes). This folder might be
some type of shortcut or alias to `/var/lib/snapd/snaps`.

**2**

> `/var` is part of the root file system and contains **var**iable data files. This includes spool
  directories and files, administrative and logging data, and transient and temporary files.
>
> `/var/lib` holds state information pertaining to an application or the system. State information
  is data that programs modify while they run, and that pertains to one specific host. Users must
  never need to modify files in `/var/lib` to configure a package's operation, and the specific
  file hierarchy used to store the data must not be exposed to regular users. [Data with exposed
  filesystem structure should be stored in `/srv`.]
> 
> State information is generally used to preserve the condition of an application (or a group of
  interrelated applications) between invocations and between different instances of the same
  application. State information should generally remain valid after a reboot, should not be
  logging output, and should not be spooled data. An application (or a group of inter-related
  applications) must use a subdirectory of `/var/lib` for its data ...


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## 2. Try to fix it

`snap list --all` will give you a list of all the "snaps" and whether they are disabled or not.

### Clean by hand

```Bash

snap list --all 
cd /var/lib/snapd/snaps
sudo snap remove audacity --revision 1196
# sudo snap remove name_of_program --revision (revision number)

```

### Use script

Consider using [this script][stack_1_a] (also seen below) to delete older versions of snap.

```Bash
#!/bin/bash

# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu
    # -e  Exit immediately if a command exits with a non-zero status.
    # -u  Treat unset variables as an error when substituting.

LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done
```

<!-- Talk about how using the script above worked -->

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## 3. 

[This section is yet to be written and should probably be about deleting all of snap and instead using dpkg/apt]

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Further Reading

* [This link][stack_1] contains a lot of information on this problem, including popey's script
  (used above) and [another version of the script][stack_1_a_maybe_improved].

* The [snap manual][snap_manual]




[stack_1]: https://superuser.com/questions/1310825/how-to-remove-old-version-of-installed-snaps
[stack_1_a]: https://superuser.com/a/1330590
[stack_1_a_maybe_improved]: https://superuser.com/a/1610297
[snap_manual]: https://manpages.ubuntu.com/manpages/focal/man8/snap.8.html
