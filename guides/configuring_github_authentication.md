# About commit signature verification

[Reference][about_commit_sign_verif]

## Keys

Using GPG, SSH, or S/MIME, you can sign tags and commits locally. These tags or commits are marked
as verified on GitHub so other people can be confident that the changes come from a trusted source.
Displaying verification statuses for all of your commits. For most individual users, GPG or SSH
will be the best choice for signing commits.

* S/MIME signatures are usually required in the context of a larger organization. 

* SSH signatures are the simplest to generate. You can even upload your existing authentication key
  to GitHub to also use as a signing key. 

* Generating a GPG signing key is more involved than generating an SSH key, but GPG has features
  that SSH does not. A GPG key can expire or be revoked when no longer used. The GPG signature may
  include the information about it being expired or revoked.

<!-- Is this important? saving for later -->
<!-- Depending on whether you have enabled vigilant mode, commits and tags have the following verification statuses: -->
<!-- * Verified - the commit is signed and the signature was successfully verified -->
<!-- * Unverified - the commit is signed but the signature could not be verified -->
<!-- * No verification status - the commit is not signed -->
<!-- By default vigilant mode is not enabled. For information on how to enable vigilant mode, see [Displaying verification statuses][] for all of your commits. -->
<!-- [Displaying verification statuses]: https://docs.github.com/en/authentication/managing-commit-signature-verification/displaying-verification-statuses-for-all-of-your-commits -->


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## SSH commit signature verification

[Reference][ssh_commit_sign_verif]

You can use SSH to sign commits with an SSH key that you generate yourself. 

GitHub uses `ssh_data`, an open source Ruby library, to confirm that your locally signed commits and
tags are cryptographically verifiable against a public key you have added to your account on
GitHub.com.

If you already use an SSH key to authenticate with GitHub, you can also upload that same key again
for use as a signing key. There's no limit on the number of signing keys you can add to your
account.

For more information, see the [Git reference documentation] for `user.Signingkey`.

**Steps to sign commits using SSH and have those commits verified on GitHub**:

1. Check for existing SSH keys
2. Generate a new SSH key
3. Add a SSH signing key to your GitHub account
4. Tell Git about your signing key
5. Sign commits
6. Sign tags

### 1. Check for existing SSH keys

[Reference][step_1]

Before you generate an SSH key, you can check to see if you have any existing SSH keys.

1. Open the terminal and enter `ls -al ~/.ssh` to list the contents of the `.ssh` directory and see
if existing SSH keys are present.

```Bash
ls -al ~/.ssh
# Lists the files in your .ssh directory, if they exist
```

2. Check the directory listing to see if you already have a public SSH key. By default, the
filenames of supported public keys for GitHub are one of the following.

* `id_rsa.pub`
* `id_ecdsa.pub`
* `id_ed25519.pub`

If you receive an error that `~/.ssh` doesn't exist, you do not have an existing SSH key pair in the
default location. You can create a new SSH key pair in the next step.

3. Either generate a new SSH key or upload an existing key

* If you don't have a supported public and private key pair, or don't wish to use any that are
  available, generate a new SSH key.

* If you see an existing public and private key pair listed (for example, id_rsa.pub and id_rsa)
  that you would like to use to connect to GitHub, you can add the key to the ssh-agent.

For more information about generation of a new SSH key or addition of an existing key to the
ssh-agent, see the next step.


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### 2. Generate a new SSH key

[Reference][step_2]



<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### 3. Add a SSH signing key to your GitHub account

[Reference][step_3]


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### 4. Tell Git about your signing key

[Reference][step_4]


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### 5. Sign commits

[Reference][step_5]


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
### 6. Sign tags

[Reference][step_6]




<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
[about_commit_sign_verif]: https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification

[ssh_commit_sign_verif]: https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification#ssh-commit-signature-verification

[step_1]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys

[step_2]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

[step_3]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account

[step_4]: https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key

[step_5]: https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits

[step_6]: https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-tags

<!-- Further -->
<!-- consider reading all this -->
<!-- https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh -->


<!-- probably delete -->
<!-- first link reviewed https://docs.github.com/en/authentication/managing-commit-signature-verification -->
