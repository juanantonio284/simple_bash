# A practical example of how APT works: Installing `R`

This didactic document adds comments and explanations to the official instructions found on
[this page][cran] with additional information from [this page][ubuntu_readme]. Also, some of the 
explanations given here are based on, or *directly copied and pasted* from, [this page][linuxize_1] 
and [this page][linuxize_2]. 

## Preliminaries

### Install packages to help installation

```Bash

# Update indices
sudo apt update

# Install two helper packages we need
sudo apt install --no-install-recommends software-properties-common dirmngr
# package 1: "software-properties-common", which contains the "add-apt-repository" utility
# package 2: "dirmngr"

```

* `add-apt-repository` is a Python script that allows you to add an APT repository to either
  `/etc/apt/sources.list` or to a separate file in the `/etc/apt/sources.list.d` directory.
  (See `man add-apt-repository` for more information.)
  
* `dirmngr`: CRL and OCSP daemon

### Configure key and repository

```Bash

# Add the signing key (by Michael Rutter) for these repos.
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
# (With the deprecation of the "apt-key" command, the recommended method for adding the key is the
# one above)

# To verify the key, run:
# gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 

# Add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
# Here we use lsb_release -cs to access which Ubuntu flavor you run: one of "jammy", impish", etc.

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Install (finally)

```Bash

sudo apt install --no-install-recommends r-base

```

## R Packages

R has myriad packages available through the Comprehensive R Archive Network (CRAN). To be able to
compile them, you need to install the R development package `r-base-dev`, which "pulls in the basic
requirements for compiling R packages". You may also need the `build-essential` development
package.

```Bash

sudo apt install r-base-dev
sudo apt install build-essential

```

A great source of information on how packages work in R can be found on [this page][debian_pack_R].

More information on the build-essential package can be found on [this page][build_ess_guide].

<!-- ———————————— -->

[If you would like to update R packages that have been installed via the Ubuntu package management
system—which are installed somewhere under `/usr/lib/`—you may want to use the source packages
from the latest version of Ubuntu (see [this page][cran2deb4ubuntu_ppa]).]

### Installing packages

R packages may then be installed by the local user/admin from the CRAN source packages, typically 
from inside R using the `install.packages("package_name_here")`function. 
You can also run `R CMD INSTALL package_name_here` from a shell.

You may run into a problem that requires Java to be updated. (See more [here][stack_1])

```Bash

# This installs a new Java Development Kit in addition to the JDKs you may already have
sudo apt install openjdk-11-jdk # change 11 to the most up-to-date version

sudo R CMD javareconf

```

### For completeness: installing RStudio

1. [Download the installer][rstudio_dl]

2. Navigate to the folder where the package was downloaded and use this line 
`sudo apt install ./package_name.deb`

```BASH

cd path/to/directory_where_the_install_file_is_located
sudo apt install ./rstudio-2025.05.1-513-amd64.deb # make sure you put this ./
# (The ./ tells apt to look for the file in the current directory)

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->

[cran]: https://cran.r-project.org/
[ubuntu_readme]: https://cran.r-project.org/bin/linux/ubuntu/fullREADME.html

[linuxize_1]: https://linuxize.com/post/how-to-add-apt-repository-in-ubuntu
[linuxize_2]: https://linuxize.com/post/how-to-install-r-on-ubuntu-20-04/

[debian_pack_R]: https://cran.r-project.org/bin/linux/debian/

[build_ess_guide]: https://medium.com/@adwalkz/demystifying-development-a-guide-to-build-essential-in-ubuntu-for-seamless-software-compilation-b590b5a298bb

[stack_1]: https://stackoverflow.com/questions/34212378/installation-of-rjava

[cran2deb4ubuntu_ppa]: https://launchpad.net/~c2d4u.team/+archive/ubuntu/c2d4u4.0+

[rstudio_dl]: https://posit.co/download/rstudio-desktop/
