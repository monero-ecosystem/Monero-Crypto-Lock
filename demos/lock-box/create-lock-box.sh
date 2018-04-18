#!/bin/bash

if [ -z "$1" ]
   then
        echo "must specify full path specifier for lock-box!"
        exit 1
fi

lock_box=$1 # Directory that will be the lock-box
if [ -z "$2" ]
   then
        echo "must specify passphrase for the lock-box!"
        exit 1
fi

ph=$2 # The passphrase for the encrypted content.

mkdir "$1" # create the lock-box directory.

# Now the first mount of the directory will provide the encryption layer...
sudo mount -t ecryptfs $1 $1 -o key=passphrase:passwd=$ph,no_sig_cache,ecryptfs_cipher=aes,ecryptfs_key_bytes=32,ecryptfs_passthrough=n,ecryptfs_enable_filename_crypto=n;
