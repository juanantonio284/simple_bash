# SSH commit signature verification

**Background**

Using GPG, SSH, or S/MIME, you can sign tags and commits locally. 

* S/MIME signatures are usually required in the context of a larger organization. 

* SSH signatures are the simplest to generate. You can even upload your existing authentication key
  to GitHub to also use as a signing key. 

* Generating a GPG signing key is more involved than generating an SSH key, but GPG has features
  that SSH does not. A GPG key can expire or be revoked when no longer used. The GPG signature may
  include the information about it being expired or revoked.

For most individual users, GPG or SSH will be the best choice for signing commits.

<!-- The signed tags or commits are marked as verified on GitHub so other people can be confident that the changes come from a trusted source. Displaying verification statuses for all of your commits. -->

<!-- Is this important? saving for later -->
<!-- Depending on whether you have enabled vigilant mode, commits and tags have the following verification statuses: -->
<!-- * Verified - the commit is signed and the signature was successfully verified -->
<!-- * Unverified - the commit is signed but the signature could not be verified -->
<!-- * No verification status - the commit is not signed -->
<!-- By default vigilant mode is not enabled. For information on how to enable vigilant mode, see [Displaying verification statuses][] for all of your commits. -->
<!-- [Displaying verification statuses]: https://docs.github.com/en/authentication/managing-commit-signature-verification/displaying-verification-statuses-for-all-of-your-commits -->

[(link to original page)][about_commit_sign_verif]


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## TLDR

```Bash
### 1. Check for existing SSH keys .............................................
ls -al ~/.ssh
# Lists the files in your .ssh directory, if they exist

### 2. Generate a new SSH key ..................................................
ssh-keygen -t ed25519 -C "your_email@example.com"
# If you are using a legacy system that doesn't support the Ed25519 algorithm, use:
# ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
#     2.1. Start the ssh-agent in the background
eval "$(ssh-agent -s)"
#     2.2. Add your SSH private key to the OpenSSH authentication agent
ssh-add ~/.ssh/id_ed25519

### 3. Add a new SSH signing key (public key) to your GitHub account ...........
#    3.1
cat ~/.ssh/id_ed25519.pub
# Then select and copy the contents of the id_ed25519.pub file displayed in the terminal (i.e. the
# SSH public key) to your clipboard
#     3.2 - 9
#     Follow the steps in section 3 of this file or at the website
#     https://docs.github.com/en/authentication/connecting-to-github-with-ssh/
#             adding-a-new-ssh-key-to-your-github-account

### 4. Tell Git about your signing key
#     4.1. Configure Git to use SSH to sign commits and tags
git config --global gpg.format ssh
#     4.2. Set your SSH signing key in Git
git config --global user.signingkey /path/to/.ssh/key.pub
# substitute /path/... with the path to the public key you'd like to use

```

Solution to a potential problem  
(This shouldn't be in TLDR, you should actually read and understand what's going on.)

```Bash
ssh-keygen -R domain.example # remove old key

ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
# the command ssh-keyscan -t rsa github.com scans for the sshkey of type rsa in github.com
# >> ~/.ssh/known_hosts writes it to the known_hosts file
```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Sign commits using SSH and have those commits verified on GitHub

You can access and write data in repositories on GitHub using SSH (Secure Shell Protocol). 

* When you connect via SSH, you authenticate using a private key file on your local machine
    - When you set up SSH, you need to generate a private/public key pair and add the private key to
      the SSH agent
* You must also add the public SSH key to your account on GitHub before you use the key to
  authenticate or sign commits <!-- source: [about_ssh] -->
* Github gives you the option to select whether a key you're uploading is for authentication or
  signing (apparently, authentication is the default)
  - If you want to use an SSH key that you already use to authenticate with GitHub, you should
    upload that same key again for use as a signing key
  - There's no limit on the number of signing keys you can add to your account. For more
    information, see the Git documentation for `user.Signingkey`.

#### Steps:

1. Check for existing SSH keys
2. Generate a new SSH key  
    * add the new key to the ssh-agent
3. Add a new SSH signing key (public key) to your GitHub account
4. Tell Git about your signing key
5. Sign commits
6. Sign tags

[(link to original page)][ssh_commit_sign_verif]

### 1. Check for existing SSH keys

Before you generate an SSH key, you can check to see if you have any existing SSH keys.

1. Open Terminal and enter `ls -al ~/.ssh` to list the contents of the `.ssh` directory and see if
existing SSH keys are present.

    ```Bash
    ls -al ~/.ssh
    # Lists the files in your .ssh directory, if they exist
    ```

2. Check the directory listing to see if you already have a public SSH key. By default, the
filenames of supported public keys for GitHub are one of the following.

    * `id_rsa.pub`
    * `id_ecdsa.pub`
    * `id_ed25519.pub`

    If you receive an error that `~/.ssh` doesn't exist, you do not have an existing SSH key pair in
    the default location. You can create a new SSH key pair in the next step.

3. Either generate a new SSH key or upload an existing key

    * If you don't have a supported public and private key pair, or don't wish to use any that are
      available, generate a new SSH key.
    * If you see an existing public and private key pair listed (for example, id_rsa.pub and id_rsa)
      that you would like to use to connect to GitHub, you can add the key to the ssh-agent.

    For more information about generation of a new SSH key or addition of an existing key to the
    ssh-agent, see the next step.

[(link to original page)][step_1]

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### 2. Generate a new SSH key

When you generate an SSH key, you can add a passphrase to further secure the key. Whenever you use
the key, you must enter the passphrase. If your key has a passphrase and you don't want to enter
the passphrase every time you use the key, you can add your key to the SSH agent. The SSH agent
manages your SSH keys and remembers your passphrase.

After you generate the key, you can add the public key to your account on GitHub.com to enable
authentication for Git operations over SSH.

1. Open Terminal and enter the text below, replacing the email used in the example with your GitHub
email address. (This creates a new SSH key, using the provided email as a label.)

    ```Bash
    ssh-keygen -t ed25519 -C "your_email@example.com"
    # If you are using a legacy system that doesn't support the Ed25519 algorithm, use:
    # ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    ```

2. Decide where to save the key

    ```
    > Enter a file in which to save the key (/home/YOU/.ssh/id_ALGORITHM):[Press enter]
    ```
    
    Press Enter to accept the default file location. Please note that if you created SSH keys
    previously, `ssh-keygen` may ask you to rewrite another key, in which case we recommend
    creating a custom-named SSH key. To do so, type the default file location and replace
    `id_ALGORITHM` with your custom key name.

3. At the prompt, type a secure passphrase. 

    ```
    > Enter passphrase (empty for no passphrase): [Type a passphrase]
    > Enter same passphrase again: [Type passphrase again]
    ```

#### Add the new key to the ssh-agent

[Note: Before adding a new SSH key to the ssh-agent to manage your keys, you should have checked for
 existing SSH keys and generated a new SSH key.]

1. Start the ssh-agent in the background

    ```Bash
    eval "$(ssh-agent -s)"
    # > Agent pid 59566
    ```
    
    Depending on your environment, you may need to use a different command. (For example, you may
    need to use root access by running `sudo -s -H` before starting the ssh-agent, or you may need
    to use `exec ssh-agent bash` or `exec ssh-agent zsh` to run the ssh-agent.)

2. Add your SSH private key to the OpenSSH authentication agent

    If you created your key with a different name, or if you are adding an existing key that has a
    different name, replace `id_ed25519` in the command with the name of your private key file.
    
    ```Bash
    ssh-add ~/.ssh/id_ed25519
    ```

[(link to original page)][step_2]

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### 3. Add a new SSH signing key (public key) to your GitHub account

To configure your account on GitHub.com to use your new (or existing) SSH key, you'll also need to
add the key to your account.

* You can access and write data in repositories on GitHub using SSH (Secure Shell Protocol). When
  you connect via SSH, you authenticate using a private key file on your local machine
* You can also use SSH to sign commits and tags. For more information about commit signing, see
  About commit signature verification.
* You can add an SSH key and use it for authentication, or commit signing, or both. If you want to
  use the same SSH key for both authentication and signing, you need to upload it twice.

After adding a new SSH authentication key to your account on GitHub.com, you can reconfigure any
local repositories to use SSH. For more information, see Managing remote repositories.
<!-- https://docs.github.com/en/get-started/git-basics/managing-remote-repositories#switching-remote-urls-from-https-to-ssh -->

Since these instructions are related to the github website and could possibly change, it's probably
better to [see them online][step_3]

————————————

1. Copy the SSH public key to your clipboard

    If your SSH public key file has a different name than the example code, modify the filename to
    match your current setup. When copying your key, don't add any newlines or whitespace.

    ```Bash
    $ cat ~/.ssh/id_ed25519.pub
    # Then select and copy the contents of the id_ed25519.pub file
    # displayed in the terminal to your clipboard
    ```
    
    Alternatively, you can locate the hidden .ssh folder, open the file in your favorite text
    editor, and copy it to your clipboard.

2. In the upper-right corner of any page on GitHub, click your profile photo, then click Settings
(gear icon)

3. In the "Access" section of the sidebar, click SSH and GPG keys (key icon) 

4. Click New SSH key or Add SSH key.

5. In the "Title" field, add a descriptive label for the new key. For example, if you're using a
personal laptop, you might call this key "Personal laptop".

6. Select the type of key, either authentication or signing. For more information about commit
signing, see About commit signature verification.

7. In the "Key" field, paste your public key.

8. Click Add SSH key.

9. If prompted, confirm access to your account on GitHub. For more information, see Sudo mode.

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### 4. Tell Git about your signing key

To sign commits locally, you need to inform Git that there's a GPG, SSH, or X.509 key you'd like to
use.

```Bash
# 4.1. Configure Git to use SSH to sign commits and tags
git config --global gpg.format ssh

# 4.2. Set your SSH signing key in Git
git config --global user.signingkey /path/to/.ssh/key.pub
# substitute /path/... with the path to the public key you'd like to use
```

[(link to original page)][step_4]

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### 5. Sign commits

If you have multiple keys or are attempting to sign commits or tags with a key that doesn't match
your committer identity, you should tell Git about your signing key (see previous step).

1. Signing a commit

    ```Bash
    git commit -S -m "YOUR_COMMIT_MESSAGE"
    # -S: creates a signed commit
    # if using GPG, after creating the commit, provide the passphrase (set up when the key was generated)
    ```

2. Push local commits to the remote repository on GitHub

    ```Bash
    git push
    ```

<!-- NOT SURE WHAT ALL THIS IS ABOUT! -->
<!-- STEPS 4 AND 5 -->
<!-- On GitHub, navigate to your pull request. -->
<!-- On the pull request, click `Commits`. -->
<!-- Screenshot of the title and tabs on a pull request. The "Commits" tab is outlined in dark orange. -->
<!-- STEP 6 -->
<!-- To view more detailed information about the verified signature, click `Verified`. -->
<!-- Screenshot of a commit in the commit list for a repository. "Verified" is highlighted with an orange outline. -->


<!-- NOTICE THAT ALL OF THIS IS ABOUT GPG -->

<!-- To configure your Git client to sign commits by default for a local repository run  -->
<!-- `git config commit.gpgsign true`.  -->
<!-- To sign all commits by default in any local repository on your computer run  -->
<!-- `git config --global commit.gpgsign true`. -->

<!-- About GPG key passphrase[^note_gpg]. -->

<!-- [^note_gpg]: To store your GPG key passphrase so you don't have to enter it every time you sign
a commit, we recommend using the following tools: For Mac users, the GPG Suite allows you to
store your GPG key passphrase in the macOS Keychain. For Windows users, the Gpg4win integrates
with other Windows tools. You can also manually configure gpg-agent to save your GPG key
passphrase, but this doesn't integrate with macOS Keychain like ssh-agent and requires more
setup. -->

[(link to original page)][step_5]

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### 6. Sign tags

You can sign tags locally using GPG, SSH, or S/MIME.

1. Signing a tag

    ```Bash
    git tag -s MYTAG
    # -s: creates a signed tag
    ```
2. Verify a signed tag

    ```Bash
    git tag -v [tag-name]
    ```

[(link to original page)][step_6]


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## A Problem I Ran Into

[See the original stackoverflow solution here][solution]

**Problem**

```
Host key verification failed.
fatal: Could not read from remote repository.
```

**Explanation**

When using SSH, every host has a key. Clients remember the host key associated with a particular
address and refuse to connect if a host key appears to change. This prevents man in the middle
attacks. 

The reason for the error message is that `domain.example` is no longer in your known_hosts after
deleting it and presumably not in the system's `known_hosts` file, so `ssh` has no way to know
whether the host on the other end of the connection is really `domain.example`. 

**Solution**

*If this does not seem fishy to you*, remove the old key yourself by editing 
`${HOME}/.ssh/known_hosts` to remove the line for `domain.example`. Or let an SSH utility do it for
you with:

```Bash
ssh-keygen -R domain.example # remove old key
```

From here, record the updated key: 

```Bash
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
# the command ssh-keyscan -t rsa github.com scans for the sshkey of type rsa in github.com
# >> ~/.ssh/known_hosts writes it to the known_hosts file

# just for reference, there is a "/etc/ssh/ssh_config" file in the system you might want to look at
# in the future ...
```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Further

* [General information on ssh][about_ssh]
* [Adding or changing a passphrase][working_with_ssh_pass]
* [Delete and approve ssh keys on Github][review_ssh]
* [A troubleshooting section][troubleshooting]
* [All of github's documentation regarding authentication][all_authentication] (any link found in
  this document, and many more, can be found here)


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
<!-- links inside the regular text -->
[about_commit_sign_verif]: https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification

[ssh_commit_sign_verif]: https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification#ssh-commit-signature-verification

[step_1]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys

[step_2]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

[step_3]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account

[step_4]: https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key

[step_5]: https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits

[step_6]: https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-tags

[solution]: https://stackoverflow.com/a/13364116

<!-- links for "Further" section -->

[all_authentication]: https://docs.github.com/en/authentication

[about_ssh]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh

[working_with_ssh_pass]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/working-with-ssh-key-passphrases

[review_ssh]: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/reviewing-your-ssh-keys

[troubleshooting]: https://docs.github.com/authentication/troubleshooting-ssh
