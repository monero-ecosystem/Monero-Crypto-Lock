#!/bin/bash

# This script starts up the Monero Crypto-Lock dependencies. Specifically:
# monerod
# monero-wallet-rpc
#
# Specify the full path of your monero directory and 
# the location of your wallet:
xmdir=''
wallet=''
# examples:
#xmrdir='/home/user/monero-v0.12.3.0'
#wallet='/home/user/monero-v0.12.0.0/test'


#change to the Monero directory
cd "$xmrdir"

./monerod --offline --detach
./monero-wallet-rpc --rpc-bind-port 18083 --disable-rpc-login --wallet-file $wallet --prompt
