#!/bin/bash
# This script displays the first 64-characters of the passed Monero address.
# used for ecryptfs passphrase for example purposes.
# The Monero address is passed as a command line argument.

address=$1

passphrase=${address:0:64}

echo "$passphrase"
