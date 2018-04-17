#!/bin/bash

lock_box=$1; # Full path of lock-box directory to create.
ph=$2; # Passphrase
algo=$3; # Algorithm to transform passphrase.

mkdir "$1"; # Create the lock-box directory.
tf=`echo -n "$ph" | openssl dgst -"$algo"`; # run the passphrase through the user specified algorithm.
tf=${tf#*= }; # strip (stdin)= from the string
echo "$ph"; # echo passphrase
echo "$tf"; # echo passphrase algo transform string
ts=${tf:0:64}; # Max of 64-chars for ecryptfs passphrase
echo "$ts"; #echo the passphrase for ecryptfs use

# Now have ecryptfs mount the lock-box.
sudo mount -t ecryptfs $1 $1 -o key=passphrase:passwd=$ts,no_sig_cache,ecryptfs_cipher=aes,ecryptfs_key_bytes=32,ecryptfs_passthrough=n,ecryptfs_enable_filename_crypto=n;

