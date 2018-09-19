#!/bin/bash
# 19 September 2018
# This script uses Monero Crypto-Lock to encrypt a specified file using gpg.
# The source plaintext file is removed with secure delete.
# 
# This version replaces the prior version which used the Monero wallet public address as
# the gpg passphrase. This version uses the private spend key of the Monero wallet
# as the gpg passphrase for file encryption.
#
# generate a random string for the challenge.
function randomString {
        # if a param was passed, it's the length of the string we want
        if [[ -n $1 ]] && [[ "$1" -lt 20 ]]; then
                local myStrLength=$1;
        else
                # otherwise set to default
                local myStrLength=8;
        fi

        local mySeedNumber=$$`date +%N`; # seed will be the pid + nanoseconds
        local myRandomString=$( echo $mySeedNumber | md5sum | md5sum );
        # create our actual random string
        myRandomResult="${myRandomString:2:myStrLength}"
}

randomString 10;
echo "Challenge: $myRandomResult";
# Get (from stdin) the file to encrypt (full path), challenge string, address, and signature from the console. each separated by a space.
read target_file challenge address signature


echo "################################"
echo "Parameters provided:"
echo "Full path file to encrypt: $target_file"
echo "Challenge: $challenge"
echo "Address: $address"
echo "Signature: $signature"
echo "################################"


buff=`curl -X POST http://127.0.0.1:18083/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"verify","params":{"data":"'"$challenge"'","address":"'"$address"'","signature":"'"$signature"'"}}' -H 'Content-Type: application/json'`

pass="true"
if echo "$buff" | grep -q "$pass"; then
# sign the address and use the private spend key as the gpg passphrase.
sbuff=`curl -X POST http://127.0.0.1:18083/json_rpc -d '{"jsonrpc":".0","id":"0","method":"query_key","params":{"key_type":"spend_key"}}' -H 'Content-Type: application/json'`
# parse the returned json.
var="key"
rt=$(echo "$sbuff" | grep "$var")
var=${rt: -66}
sk=${var:0:64}

# encrypt the file using the private spend key as the passphrase.
 gpg --passphrase "$sk" -c $target_file ; # Encrypt the file.
 srm $target_file # securely remove the source plaintext file.
else

 echo "Authorization has failed!";
fi

