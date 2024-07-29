# Package Management

## Basic Information

[Taken from Shotts, *The Linux Command Line* (Fifth Internet Edition)]

**Packaging Systems**

Different distributions use different packaging systems, and as a general rule, a package intended
for one distribution is not compatible with another distribution. Most distributions fall into
one of two camps of packaging technologies: the Debian `.deb` camp and the Red Hat `.rpm` camp.

**Dependencies**

Programs are seldom "standalone"; rather they rely on the presence of other software components to
get their work done. Common activities, such as input/output for example, are handled by routines
shared by many programs. These routines are stored in what are called shared libraries, which
provide essential services to more than one program. If a package requires a shared resource such
as a shared library, it is said to have a dependency. Modern package management systems all provide
some method of dependency resolution to ensure that when a package is installed, all of its
dependencies are installed, too.

**High and Low-level Package Tools**

Package management systems usually consist of two types of tools: low-level tools which handle tasks
such as installing and removing package files, and high-level tools that perform metadata searching
and dependency resolution.

Debian-style distributions use `dpkg` as a low-level packaging system tool, and the following
high-level tools: `apt`, `apt-get`, `aptitude`


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Maintenance and Updates: The APT Tools

From [Chapter 6 of *The Debian Administrator's Handbook* by Raphael Hertzog and Roland Mas][chp_6]

[chp_6]: https://debian-handbook.info/browse/stable/apt.html

APT is the abbreviation for Advanced Packaging Tool. What makes this program "advanced" is its
approach to packages. It doesn't simply evaluate them individually, but it considers them as a
whole and produces the best possible combination of packages depending on what is available and
compatible according to dependencies.

**Vocabulary** The word 'source' can be ambiguous. A "source package" (a package containing the
source code of a program) should not be confused with a "package source" (a repository which
contains packages, e.g. a website, FTP server, CD-ROM, local directory, etc.). 
  
* APT needs to be given a "list of package sources (repositories)": the file
  `/etc/apt/sources.list`will list the different repositories that publish Debian packages. 

* APT will then import the list of packages published by each of these sources. 

This operation is achieved by downloading `Packages.xz` files (or a variant such as `Packages.gz`)
and analyzing their contents. When an old copy of these files is already present, APT can update it
by only downloading the differences.
<!-- (see sidebar "*TIP Incremental updates*"). -->

### Filling in the `sources.list` File

Each active line in the `/etc/apt/sources.list` file represents a package source (repository) and is
made of at least three parts separated by spaces. For a complete description of the file format and
the accepted entry compositions see sources.list(5)

**Example 6.1.** Example entry format in `/etc/apt/sources.list`

```

deb url distribution component1 component2 component3 [..] componentX
deb-src url distribution component1 component2 component3 [..] componentX

```

* The first field, `deb` or `deb-src`: 

  - `deb` indicates package source (repository) of binary packages 

  - `deb-src` indicates package source (repository) of source packages 

* The second field, `URL` gives the base URL of the source:

* The syntax of the last field depends on the structure of the repository; in the example below you
  have the name of the distribution and other data

`deb http://us.archive.ubuntu.com/ubuntu/ jammy main restricted`

**The `/etc/apt/sources.list.d/` directory**

If many package sources are referenced, it can be useful to split them in multiple files; thus in
the directory `/etc/apt/sources.list.d/`, there are various files with `.list` extension.

*Excursus*: Directories with a `.d `suffix are used more and more often. Each directory represents a
configuration file which is split over multiple files. In this sense, all of the files in
`/etc/apt/apt.conf.d/` are instructions for the configuration of APT. APT includes them in
alphabetical order, so that the last ones can modify a configuration element defined in one of the
first ones ... [(Read more)][continues_1]

### aptitude, apt-get, and apt Commands

**APT** is a vast project, whose original plans included a graphical interface. It is based on a
library which contains the core application, and **apt-get** is the first front end which was
developed within the project. **apt** is a second command-line based front end provided by APT
which overcomes some design mistakes of apt-get. 

Both tools are built on top of the same library and are thus very close, but the default behavior
of **apt has been improved for interactive use and to actually do what most users expect**. The APT
developers reserve the right to change the public interface of this tool to further improve it.
Conversely, the public interface of apt-get is well defined and will not change in any backwards
incompatible way. Thus, **apt-get is the tool that you want to use when you need to script package
installation requests**.

Numerous other graphical interfaces then appeared as external projects: synaptic, aptitude
(which includes both a text mode interface and a graphical one — even if not complete yet), wajig,
etc. **The most recommended interface, apt, is the one that we will use in the examples given in
this section**.

**Initializing**

For any work with APT, the list of available packages needs to be updated; this can be done simply
with `sudo apt update`. 

**Installing and Removing**

With APT, packages can be added or removed from the system, respectively with `apt install package`
and `apt remove package`. In both cases, APT will automatically install the necessary dependencies
or delete the packages which depend on the package that is being removed. The `apt purge package`
command involves a complete uninstallation by deleting the configuration files as well. 

If the file `sources.list` mentions several distributions, it is possible to give the version of the
package to install. A specific version number can be requested with `apt install package=version`.
But it is preferred to indicate its distribution of origin (Stable, Testing or Unstable) with `apt
install package/distribution`. With this command, it is possible to go back to an older version of
a package, provided that it is still available in one of the sources referenced by the
`sources.list` file. Otherwise the snapshot.debian.org archive can come to the rescue.
[(Read more)][continues_2]

<!-- https://debian-handbook.info/browse/stable/sect.apt-get.html -->

#### System Upgrade

Regular upgrades are recommended, because they include the latest security updates. 

To upgrade: 

* update the list of available packages using `apt update`
* use `apt upgrade`, `apt-get upgrade` or `aptitude safe-upgrade`

This command looks for installed packages which can be upgraded without removing any packages. In
other words, the goal is to ensure the least intrusive upgrade possible. (apt-get is slightly more
demanding than aptitude or apt because it will refuse to install packages which were not installed
beforehand.)

apt will generally select the most recent version number (except for packages from Experimental and
stable-backports, which are ignored by default whatever their version number). If you specified
Testing or Unstable in your sources.list, apt upgrade will switch most of your Stable system to
Testing or Unstable, which might not be what you intended.

To tell apt to use a specific distribution when searching for upgraded packages, you need to use the
`-t` or `--target-release` option, followed by the name of the distribution you want (for example,
`apt -t stable upgrade`). To avoid specifying this option every time you use apt, you can add
`APT::Default-Release "stable"`; in the file `/etc/apt/apt.conf.d/local`.

For more important upgrades, such as the change from one major Debian version to the next, you need
to use `apt full-upgrade`. With this instruction, apt will complete the upgrade even if it has to
remove some obsolete packages or install new dependencies. This is also the command used by users
who work daily with the Debian Unstable release and follow its evolution day by day. It is so
simple that it hardly needs explanation: APT's reputation is based on this great functionality.
Unlike apt and aptitude, apt-get doesn't know the full-upgrade command. Instead, you should use
`apt-get dist-upgrade` ("distribution upgrade"), the historical and well-known command that apt and
aptitude also accept for the convenience of users who got used to it. 

The results of `apt`'s operations are logged into `/var/log/apt/history.log` and
`/var/log/apt/term.log`.  
`dpkg` keeps its log in a file called `/var/log/dpkg.log`.


[continues_1]: https://debian-handbook.info/browse/stable/sect.apt-get.html#sidebar.directory.d
[continues_2]: https://debian-handbook.info/browse/stable/apt.html#sidebar.snapshot.debian.org

#### Configuration Options

Besides the configuration elements already mentioned, it is possible to configure certain aspects of
APT by adding directives in **a file of** the `/etc/apt/apt.conf.d/` directory **or**
`/etc/apt/apt.conf` itself. Remember, for instance, that it is possible for APT to tell `dpkg` to
ignore file conflict errors by specifying `DPkg::options { "--force-overwrite"; }`.
