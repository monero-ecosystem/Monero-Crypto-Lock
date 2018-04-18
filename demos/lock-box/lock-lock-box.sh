#!/bin/bash
# 18 April 2018
# Lock Monero Crypto-Lock lock-box
# The lock-box to lock is passed as the only command line argument.
# Must specify the full path for the lock-box

if [ -z "$1" ]
   then
        echo "must specify full path specifier for lock-box!"
        exit 1
fi
lock_box=$1

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

read challenge address signature



echo "################################"
echo "Parameters provided:"
echo "Challenge: $challenge"
echo "Address: $address"
echo "Signature: $signature"
echo "################################"



buff=`curl -X POST http://127.0.0.1:18083/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"verify","params":{"data":"'"$challenge"'","address":"'"$address"'","signature":"'"$signature"'"}}' -H 'Content-Type: application/json'`

pass="true"
if echo "$buff" | grep -q "$pass"; then
 sudo umount $lock_box

 echo "Lock Box has been closed"
else

 echo "authentication failed!";
fi

