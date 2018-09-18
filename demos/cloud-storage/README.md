This directory provides examples for storing sensitive data securely in the cloud
(i.e., on remote computers not under your direct control).

The first approach described here involves using Monero Crypto Lock using ecryptfs to manage an encrypted directory structure that can be locked (encrypted and unmounted) and unlocked (decrypted and mounted) following these steps:

1. When preparing to remotely store the encrypted directory in the cloud, first you must lock it so that it is unreadable when stored in the cloud.

2. Archive the entire encrypted directory structure and compress it using a format similar to tar.gz. The entire encrypted directory structure will then be packaged as a single compressed file that can be stored in the cloud.

3. The compressed archive file can now be stored in the cloud (i.e., stored on a VPS file system, stored in a distributed file system such as IPFS, etc.). For example, if you store the file on a VPS using a utility such as scp, the data residing inside the encrypted directory structure, packaged in the compressed archive file will be safe from administrators working on behalf of the organization providing the VPS service as well as from any other user that has access to the VPS the encrypted file is stored on. (It is recommended that you generate a cryptographic hash such as SHA256 for the file so that you can verify that it has not been tampered with while it was stored remotely. Backups of the encrypted, compressed archive file should be maintained to prevent data loss.)

4. When you wish to access the data within the encrypted, compressed, archive file, you will need to:
-download the file to your computer
-uncompress it
-unarchive it
-then unlock the directory with Monero Crypto Lock

The content in this directory will describe some use cases for securely storing sensitive data in remote locations using Monero Crypto Lock.
