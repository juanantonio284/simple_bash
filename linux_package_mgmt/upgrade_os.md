# Upgrade to Ubuntu 24.04 using command line

As usual, these are my notes and I consider them better organized and/or better written than
different sources already available. But, credit where credit is due, the page below was my main
source for this:

https://itsfoss.com/upgrade-ubuntu-version/#method-2-upgrade-to-ubuntu-2404-using-command-line

Make sure you look at many references and are absolutely sure of what you're doing before typing
commands in the shell. An operating system upgrade is **not** a small thing and this is not meant
to be a thorough guide—it's barely a guide as it is, it's more of a log of what worked for me.


1. See what version of Ubuntu you have: 

```Bash
lsb_release -a
```

2. Make sure that you have the `update-manager-core` package installed

```Bash
sudo apt install update-manager-core
```

3. Open the file `/etc/update-manager/release-upgrades` and set `Prompt=lts`

```Bash
subl /etc/update-manager/release-upgrades # open in sublime text
```

4. Install any pending software updates

```Bash
sudo apt update && sudo apt dist-upgrade
```

5. After this, run the following command to upgrade to Ubuntu 24.04

```Bash
sudo do-release-upgrade # this starts the major OS release upgrade
```

## Further: data sources

Third-party repositories may have been disabled before the Ubuntu version upgrade, and you may want
to enable them.

Only do this if you know what you're doing. [Read the manual!][man_sources_list] and 
see [this simple tutorial][manage_repos] (steps 3 and 4).

In this version of ubuntu, this message is in the `sources.list` file: `# Ubuntu sources have moved
to /etc/apt/sources.list.d/ubuntu.sources`. Seems like the file `ubuntu.sources` only covers basic
ubuntu things, and the sources for third party apps are all in separate entries in the
`/etc/apt/sources.list.` directory.

[man_sources_list]: https://manpages.ubuntu.com/manpages/xenial/man5/sources.list.5.html
[manage_repos]: https://jumpcloud.com/blog/how-to-manage-apt-repositories-debian-ubuntu
