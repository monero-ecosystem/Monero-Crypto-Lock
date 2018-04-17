#!/bin/bash
# Version 2 includes passphrase algorithmic transformation.

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

read challenge address signature algo



echo "################################"
echo "Parameters provided:"
echo "Challenge: $challenge"
echo "Address: $address"
echo "Signature: $signature"
echo "Algorithm: $algo"
echo "################################"



buff=`curl -X POST http://127.0.0.1:18083/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"verify","params":{"data":"'"$challenge"'","address":"'"$address"'","signature":"'"$signature"'"}}' -H 'Content-Type: application/json'`

pass="true"
if echo "$buff" | grep -q "$pass"; then
 tf=`echo -n "$ph" | openssl dgst -"$algo"`; #passphrase run through algo
 tg=${tf#*= }; #strip (stdin)=
 ts=${tg:0:64}; # max ecryptfs passphrase of 64-characters.
 echo "$tg";
 echo "$ts"; # ecryptfs passphrase.
 sudo mount -t ecryptfs /home/user/my-lock-box /home/user/my-lock-box -o key=passphrase:passwd=$ts,no_sig_cache,ecryptfs_cipher=aes,ecryptfs_key_bytes=32,ecryptfs_passthrough=n,ecryptfs_enable_filename_crypto=n;

 echo "Lock Box has been opened"
else

 echo "authentication failed!";
fi

