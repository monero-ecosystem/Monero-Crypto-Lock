This directory provides examples for storing sensitive data securely in the cloud
(i.e., on remote computers not under your direct control).

The first approach described here involves using Monero Crypto Lock using ecryptfs to manage an encrypted directory structure that can be locked (encrypted and unmounted) and unlocked (decrypted and mounted) following these steps:

1. When preparing to remotely store the encrypted directory in the cloud, first you must lock it so that it is unreadable when stored in the cloud.

2. Archive the entire encrypted directory structure and compress it using a format similar to tar.gz. The entire encrypted directory structure will then be packaged as a single compressed file that can be stored in the cloud.

