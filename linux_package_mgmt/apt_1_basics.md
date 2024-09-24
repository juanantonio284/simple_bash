# `dpkg`, `apt`, `apt-get`

## Clarification

* `dpkg` is the package that really performs the installation, i.e. the low-level background
  application
* The `apt-get` command is a full-featured but simplified interface to `dpkg`
* `apt` is a more user-friendly but slightly stripped-back version of `apt-get`
    - `apt` provides more information of the type the average user wants to see during an
      installation and suppresses some of the more obscure information that `apt-get` displays.
      (It also gives superior visual feedback and uses color highlights and progress bars in the
      terminal window.)

But `apt-get` and `apt` provide more than just an easy interface to `dpkg`; they do things that
`dpkg` doesn't do. They will retrieve files from repositories and will try to assist with missing
dependencies and conflicts.

"APT" may refer to:

* The Advanced Package Tool (or APT), the main command-line package manager for Debian and its
  derivatives. It provides command-line tools for searching, managing and querying information
  about packages, as well as low-level access to all features provided by the libapt-pkg and
  libapt-inst libraries.

* The apt package, providing, among others, the apt management tool, a high-level command-line
  interface for better interactive usage. 


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## APT Selected commands

All of these commands can be preceded by `apt` or `apt-get` and will behave the same.

**General Update Operations**

* `update` - update the list of available packages
* `upgrade` - upgrade all packages
* `autoremove` - remove libraries and other packages that are no longer required
* `apt full-upgrade` - upgrades the operating system (replaces the `apt-get dist-upgrade` option)

**Basic Package Operations**

* `install packagename` - install a package
* `remove packagename` - remove (uninstall) a package
* `purge packagename` - remove a package **and** its configuration files
* `update packagename` - update the repository information

**Get information**

* `apt search packagename` - search for a package name in the repositories 
* `apt show packagename` - show information about a package
* `apt list option packagename` - shows lists of installed or upgradable packages
* `apt edit-sources` - directly edits the list of repositories where `apt` searches for packages

**See installed applications**

* `apt list --installed | grep -i package-name` - find packages of interest
* `apt list --installed` - see the list of applications installed on your computer
* `apt list --installed > apt_list_installed.txt` - output the list of installed applications to a
  file


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Updating applications

### TLDR

```Bash

# the commands below are optional and are independent from one another; you can run one or all in
# any order (But it wouldn't make sense to upgrade without doing an update before; nor to do a
# simulated upgrade after a real one.)

sudo apt update         # .... (i)
apt list --upgradable  # .... (ii)
apt --simulate upgrade # .... (iii)
sudo apt upgrade       # .... (iv)

# (i) download package information from all configured sources. Other commands operate on this data
#     to e.g. perform package upgrades or search in and display details about all packages available
#     for installation.

# (ii) list the applications that can be upgraded, also accepts the word 'upgradeable'

# (iii) at the end of a simulation you will get a message like:
#       "0 upgraded, 0 newly installed, 0 to remove and 9 not upgraded"; which might be useful to
#       see where there will be conflicts

# (iv) This will attempt to gently upgrade the whole system; it will never install a new package or
#      remove an existing package, nor will it ever upgrade a package that might cause some other
#      package to break. This can be used daily to relatively safely upgrade the system.

```


### Explanation

`apt` provides a simple way to install packages from the command line.
 
The **first thing** that should be done before using `apt` is to fetch the package lists from the
Sources[^note_1] so that it knows what packages are available; this is done with

[^note_1]: Unlike dpkg, apt-get does not understand .deb files, it works with the package's proper
name and can only install .deb archives from a Source.

```Bash

sudo apt update

```

which gives status messages like these:

```

Get:1 http://ftp.de.debian.org/debian-non-US/stable/non-US/Packages
Get:2 http://llug.sep.bnl.gov/debian/testing/contrib Packages
Hit http://llug.sep.bnl.gov/debian/ testing/main Packages
Get:4 http://ftp.de.debian.org/debian-non-US/unstable/binary-i386/Packages
Get:5 http://llug.sep.bnl.gov/debian/testing/non-free Packages
11% [5 testing/non-free `Waiting for file' 0/32.1k 0%] 2203b/s 1m52s

```

The lines starting with Get are printed out when APT begins to fetch a package information file
(not the actual package) while the last line indicates the progress of the download. The first
percent value on the progress line indicates the total percent done of all files. 
(See more [here][apt_interface])

If you were to run `sudo apt update` and, right after, run it again, you would not see "Get" again,
they would all say "Hit". This shows that 'Get' is a status message of what the program is doing
and not, in a strict sense, a signal that there is something available for updating—although it
could be interpreted that way.

Once updated you can use 

```Bash

sudo apt upgrade

```

This will attempt to gently upgrade the whole system; it will never install a new package or remove
an existing package, nor will it ever upgrade a package that might cause some other package to
break. This can be used daily to relatively safely upgrade the system. `upgrade` will list all of
the packages that it could not upgrade, this usually means that they depend on new packages or
conflict with some other package. dselect (a GUI) or apt-get install can be used to force these
packages to install

Also consider `apt full-upgrade` to upgrade the entire operating system (replaces the `apt-get
dist-upgrade` option)


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Installing applications (an example)

### 1. View applications already installed

```Bash

# See the list of applications installed on your computer
apt list --installed

# Output the list of installed applications to a file
apt list --installed > apt_list_installed.txt

# To find packages of interest, use grep and part of the name or topic of interest
apt list --installed | grep -i python

# list the applications that can be upgraded
apt list --upgradable    # also accepts the word 'upgradeable'

# Count how many packages are installed by counting lines in the list
apt list --installed | wc --lines

```

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### 2. `search` for a package

The **first thing** that should be done before using `apt` is to fetch the package lists from the
Sources so that it knows what packages are available; this is done with `sudo apt update`.

See whether a package exists in the repositories using `search`. For example, say you want to
install [Scribus][] but you don't know the package name; first you might try looking
for "scribus-desktop". 

```Bash

apt search scribus-desktop
# no results appear

```

That search didn't find anything; try again with a more generic name.

```Bash

apt search scribus

```

gives an output similar to this

```

Sorting... Done
Full Text Search... Done
create-resources/jammy,jammy 0.1.3-6 all
  shared resources for use by creative applications

icc-profiles/jammy,jammy 2.1-2 all
  ICC color profiles for use with color profile aware software

icc-profiles-free/jammy,jammy,now 2.0.1+dfsg-1.1 all [installed,automatic]
  ICC color profiles for use with color profile aware software

scribus/jammy 1.5.8+dfsg-2 amd64
  Open Source Desktop Page Layout

scribus-data/jammy,jammy 1.5.8+dfsg-2 all
  Open Source Desktop Page Layout - data files

scribus-doc/jammy,jammy 1.5.8+dfsg-1 all
  Open Source Desktop Page Layout - documentation - 1.5.x branch

scribus-template/jammy,jammy 1.2.4.1-5 all
  additional scribus templates

```

`scribus` seems to be the right option ("jammy" is the name of the distribution of the OS) 

### 3. `show` information about a package

The `show` command gives many details, including a description of the program (it also suggests
other packages that might be required, depending on our needs).

```Bash

apt show scribus

```

```

Description: Open Source Desktop Page Layout

Scribus is an open source desktop page layout program with the aim of producing commercial grade
output in PDF and Postscript.
.
Scribus can be used for many tasks; from brochure design to newspapers, magazines, newsletters and
posters to technical documentation.
...

```

### 4. `install`

```Bash

sudo apt install scribus

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Uninstalling applications

See a list of all installed packages on your computer:

```Bash

# option 1
dpkg --list

# option 2
apt list --installed

```

To uninstall and delete all the configuration files, use the `purge` command:

```Bash

sudo apt purge program_to_uninstall

```

To uninstall without deleting all the configuration files, use the `remove` command:

```Bash

sudo apt remove program_to_uninstall

```

Programs depend on other packages to function; when you uninstall a program, there may be packages
that the uninstalled program depended upon that are no longer used. To remove any unused packages,
use the `autoremove` command:

```Bash

sudo apt autoremove

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Further

The `apt` command also provides a way for you to edit the information stored about the repositories
apt searches for packages. Only do this if you 
[know what you're doing](https://manpages.ubuntu.com/manpages/xenial/man5/sources.list.5.html).

```Bash

sudo apt edit-sources # opens /etc/apt/sources.list file in terminal

subl -n /etc/apt/sources.list # opens the file in sublime text editor

```

If you double click the file `/etc/apt/sources.list` on Ubuntu, it opens a graphical `Software &
Update` settings interface. If you type `open /etc/apt/sources.list` in the terminal it will also
open the graphical interface.


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## References

* [man apt](https://manpages.ubuntu.com/manpages/xenial/man8/apt.8.html)
* https://wiki.debian.org/Apt
* https://www.debian.org/doc/manuals/apt-guide/
* https://itsfoss.com/apt-command-guide/
* https://itsfoss.com/apt-list-upgradable/ <!-- check this next -->
* https://www.howtogeek.com/791055/apt-vs-apt-get-whats-the-difference-on-linux/
* https://www.howtogeek.com/229699/how-to-uninstall-software-using-the-command-line-in-linux/

[Scribus]: https://www.scribus.net/
[apt_interface]: https://www.debian.org/doc/manuals/apt-guide/ch4.en.html
