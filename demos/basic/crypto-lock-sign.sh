#!/bin/bash

# challenge string is passed as an argument on the command line.
challenge=$1

echo "Parameters provided:"
echo "Challenge: $1"
echo "####################################"

 # Echo the Monero wallet address:
curl -i -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":"0","method":"getaddress"}' http://127.0.0.1:18082/json_rpc 

# Sign the challenge string and echo the signature:
curl -i -X POST http://127.0.0.1:18082/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"sign","params":{"data":"'"$challenge"'"}}' -H 'Content-Type: application/json'
