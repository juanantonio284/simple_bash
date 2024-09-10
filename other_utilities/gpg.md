# Encrypting files with `gpg` (GNU Privacy Guard)

## TLDR

```Bash

# ENCRYPT
gpg --symmetric --no-symkey-cache filename.txt

# DECRYPT
gpg --no-symkey-cache filename.txt.gpg

# RELOADAGENT
# run this line in case password was saved because you decrypted using only gpg filename.txt.gpg
echo RELOADAGENT | gpg-connect-agent 

# --symmetric, or -c
#   Encrypt with a symmetric cipher using a passphrase. ... GPG CACHES THE PASSPHRASE used for
#   symmetric encryption so that a decrypt operation may not require that the user needs to enter
#   the passphrase. The option --no-symkey-cache can be used to disable this feature. 

# --no-symkey-cache
#   Disable the passphrase cache used for symmetrical en- and decryption (necessary so password is
#   not saved)

# Notice that, in the decryption command, there are no arguments related to the decryption itself.
# No arguments means that the file will be extracted from the gpg (as opposed to contents being
# shown in the terminal window like in the example seen in next section).

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Some concepts

**Symmetric encryption** can be used when we don't need to share the encrypted files with anyone 
else. (If we do share, then we'd need to share the passphrase as well, which can be a potential risk
factor.)

**Asymmetric encryption** uses two data strings, one for encryption and another for decryption
(the pair of data strings are called key pairs). Asymmetric encryption is more suitable for the
sharing of encrypted files, as it requires sharing only one of the two data strings (the public
key). [Click here][link_1] for more info on keys.

```Bash

# 1. Create a file
echo "first line in the file" > file.txt

# BETTER NOT TO USE THIS (here just for learning purposes)

# 2. Encrypt
# the password is given as part of the command and will be stored in the terminal history!!
gpg --batch --output file.txt.gpg --passphrase mypassword --symmetric file.txt

# 3. Decrypt
# the password is given as part of the command and will be stored in the terminal history!!
gpg --batch --output name_given_to_decrypted_file.txt --passphrase mypassword --decrypt file.txt.gpg
# note how the gpg file is read and outputted to a new file 
# (otherwise it comes out in the terminal window)

# --batch means don't invoke a pinentry or do any other thing requiring human interaction.
#   without the batch option, a small window in the OS will ask for a password
#   CAREFUL because the OS will store the password!!
# To clear the password stored in the session, we can run:

echo RELOADAGENT | gpg-connect-agent

```


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## References

* https://linuxier.com/how-to-encrypt-files-in-linux/
* https://security.stackexchange.com/questions/103034/gnupg-decryption-not-asking-for-passphrase
* https://www.baeldung.com/linux/encrypt-decrypt-files

[link_1]: https://itsfoss.com/gpg-encrypt-files-basic/#step-2-generating-a-gpg-key
