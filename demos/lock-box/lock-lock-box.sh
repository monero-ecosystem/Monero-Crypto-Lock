#!/bin/bash

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
# Collect challenge string, address, and signature from the console. Each parameter separated from each other by a space.
read challenge address signature

#echo "$challenge $address $signature"


echo "################################"
echo "Parameters provided:"
echo "Challenge: $challenge"
echo "Address: $address"
echo "Signature: $signature"
echo "################################"


#curl -i -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":"0","method":"getaddress"}' http://127.0.0.1:18082/json_rpc
# Verify digital signature of challenge by address.
buff=`curl -X POST http://127.0.0.1:18082/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"verify","params":{"data":"'"$challenge"'","address":"'"$address"'","signature":"'"$signature"'"}}' -H 'Content-Type: application/json'`

pass="true"
if echo "$buff" | grep -q "$pass"; then
 ph=${address:0:64};
 echo "$ph";
# sudo mount -t ecryptfs /home/user/lock-box /home/user/lock-box -o key=passphrase:passwd=$ph,no_sig_cache,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_passthrough=n,ecryptfs_enable_filename_crypto=n;
 sudo umount /home/user/lock-box

 #gpg --passphrase "$address" -c /home/user/test.txt ;
 #srm /home/user/test.txt
 echo "Lock Box has been closed"
else
 #gpg --passphrase "$address" --output /home/user/test.txt /home/user/test.txt.gpg;

 echo "Lock Box is now open!";
fi
