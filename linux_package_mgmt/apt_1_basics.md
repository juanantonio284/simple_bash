# `dpkg`, `apt`, `apt-get`

**Difference between utilities**

`dpkg` is the package that really performs the installation, i.e. the low-level background
application. The `apt-get` command is a full-featured but simplified interface to `dpkg`. `apt` is
a more user-friendly but slightly stripped-back version of `apt-get`.

But `apt-get` and `apt` provide more than just an easy interface to `dpkg`; they do things that
`dpkg` doesn't do. They will retrieve files from repositories and will try to assist with missing
dependencies and conflicts.

In turn, the `apt` command does some things `apt-get` doesn't. It provides more information of the
type the average user wants to see during an installation and suppresses some of the more obscure
information that `apt-get` displays. `apt` gives superior visual feedback and uses color highlights
and progress bars in the terminal window.

From [debian wiki][wiki]: 

"APT" may refer to:

* The Advanced Package Tool (or APT), the main command-line package manager for Debian and its
  derivatives. It provides command-line tools for searching, managing and querying information
  about packages, as well as low-level access to all features provided by the libapt-pkg and
  libapt-inst libraries.

* The apt package, providing, among others, the apt management tool, a high-level command-line
  interface for better interactive usage. 
  
[In general, the commands below deal with the `apt` management tool, a high-level command-line
interface for better interactive usage.]


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Using APT

### Selected Commands

All of these commands can be preceded by `apt` or `apt-get` and will behave the same.

**General Update Operations**

* `update`: update the list of available packages
* `upgrade`: upgrade all packages
* `autoremove`: remove libraries and other packages that are no longer required
* `apt full-upgrade`: upgrades the operating system (replaces the `apt-get dist-upgrade` option)

**Basic Package Operations**

* `install packagename`: install a package
* `remove packagename`: remove (uninstall) a package
* `purge packagename`: remove a package **and** its configuration files
* `update packagename`: update the repository information

**Get information**

* `apt search packagename`: search for a package name in the repositories 
* `apt show packagename`: show information about a package
* `apt list option packagename`: shows lists of installed or upgradable packages
* `apt edit-sources`: directly edits the list of repositories where `apt` searches for packages

**See installed applications**

* `apt list --installed | grep -i package-name`: find packages of interest
* `apt list --installed`: see the list of applications installed on your computer
* `apt list --installed > apt_list_installed.txt`: output the list of installed applications to a file


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### View Installed Applications

```Bash

# See the list of applications installed on your computer
apt list --installed

# Output the list of installed applications to a file
apt list --installed > apt_list_installed.txt

# To find packages of interest, use grep and part of the name or topic of interest
apt list --installed | grep -i python

# See if any of the installed applications can be upgraded:
apt list --upgradable    # seems to also take the word 'upgradeable'

# Count how many packages are installed by counting lines in the list
apt list --installed | wc --lines

```

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### Installing Applications

#### `search` for a package

See whether a package exists in the repositories using `search`. For example, say you want to
install [Scribus][] but you don't know the package name; first you might try looking
for "scribus-desktop". 

```Bash

apt search scribus-desktop
# nothing comes out

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

#### `show` information about a package

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

#### `install`

```Bash

sudo apt install scribus

```

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### Uninstalling Applications

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

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### Other Commands

The `apt` command also provides a way for you to edit the information stored about the repositories
apt searches for packages. Only do this if you know what you're doing. 

```Bash

sudo apt edit-sources

```

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## References

https://www.howtogeek.com/791055/apt-vs-apt-get-whats-the-difference-on-linux/

https://www.howtogeek.com/229699/how-to-uninstall-software-using-the-command-line-in-linux/

[Scribus]: https://www.scribus.net/
[wiki]: https://wiki.debian.org/Apt

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->

## Further reading
<!-- update this guide using these -->

<!-- this first link seems to have the best information on the interface -->
https://www.debian.org/doc/manuals/apt-guide/ch4.en.html

<!-- sos -->
https://adamtheautomator.com/ubuntu-apt-get/

https://itsfoss.com/apt-get-linux-guide/

https://itsfoss.com/apt-command-guide/

<!-- consider this: -->

<!-- sudo apt update: When there is no package version update, you’ll see a note that says Hit. Otherwise, you’ll see a note saying Get, and the command downloads the package information (not the total package). When there is an error in retrieving the package information, it shows ign. -->

