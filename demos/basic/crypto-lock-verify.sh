#!/bin/bash

# parameters passed on the command line:
challenge=$1 # challenge string
address=$2 # Monero public address
signature=$3 # digital signature string

echo "################################"
echo "Parameters provided:"
echo "Challenge: $1"
echo "Address: $2"
echo "Signature: $3"
echo "################################"

# now verify that the signature was valid for the Monero public address and the challenge string.
curl -X POST http://127.0.0.1:18083/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"verify","params":{"data":"'"$1"'","address":"'"$2"'","signature":"'"$3"'"}}' -H 'Content-Type: application/json'

