#!/bin/bash
# 18 April 2018.
# This script decrypts a file that has been encrypted with
# crypto-lock-encrypt.sh 
#
#The encrypted source file is removed after decryption.
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
# Get the file to encrypt (full path), challenge string, address, and signature from the console. each separated by a space.
read target_file challenge address signature

echo "################################"
echo "Parameters provided:"
echo "File to decrypt (full path): $target_file"
echo "Challenge: $challenge"
echo "Address: $address"
echo "Signature: $signature"
echo "################################"



buff=`curl -X POST http://127.0.0.1:18083/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"verify","params":{"data":"'"$challenge"'","address":"'"$address"'","signature":"'"$signature"'"}}' -H 'Content-Type: application/json'`

pass="true"
if echo "$buff" | grep -q "$pass"; then
 gpg --passphrase "$address" --output /home/user/test.txt  $target_file ;
 srm /home/user/test.txt.gpg # remove the encrypted source file.
else

 echo "lock is now closed!";
fi


