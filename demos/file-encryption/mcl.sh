#!/bin/bash
# mcl.sh
# 19 September 2018
# THIS SCRIPT HAS YET TO BE FULLY TESTED!
# USE AT YOUR OWN RISK!

# This script uses Monero Crypto-Lock to encrypt/decrypy a specified file using gpg.
# The source plaintext file is removed after encryption with secure delete.
# The encrypted source file is removed after decryption with secure delete.
# 
# This version uses the private spend key of the Monero wallet
# as the gpg passphrase for file encryption/decryption.
#
# Usage patterns:
# Encryption: ./mcl.sh -c <full-path-source-file>
# example: ./mcl.sh -c /home/user/test.txt
#
#Decryption: ./mcl.sh <full-path-source-file>
# example: ./mcl.sh /home/user/test.txt.gpg
#


if [ "$#" -ge 3 ]
then
        echo "invalid number of command line arguments."
        exit
else
	
	
        if [ "$#" -eq 1 ]
	then
		#Decrypt
		# use the private spend key as the gpg passphrase.
		echo "decrypting..."
		target_file=$1
		sbuff=`curl -X POST http://127.0.0.1:18083/json_rpc -d '{"jsonrpc":".0","id":"0","method":"query_key","params":{"key_type":"spend_key"}}' -H 'Content-Type: application/json'`
		# parse the json.
		var="key"
		rt=$(echo "$sbuff" | grep "$var")
		var=${rt: -66}
		sk=${var:0:64}
		of=${target_file::-4}
 		gpg --passphrase "$sk" --output $of  $target_file ;
 		srm $target_file # remove the encrypted source file.
	else
		#Encrypt
		echo "encrypting..."
		target_file=$2
		if [ "$1" != "-c" ]
		then
			echo "invalid command line argument $1 exiting!"		
			exit
		fi
		# use the private spend key as the gpg passphrase.
		sbuff=`curl -X POST http://127.0.0.1:18083/json_rpc -d '{"jsonrpc":".0","id":"0","method":"query_key","params":{"key_type":"spend_key"}}' -H 'Content-Type: application/json'`
		# parse the returned json.
		var="key"
		rt=$(echo "$sbuff" | grep "$var")
		var=${rt: -66}
		sk=${var:0:64}
		# encrypt the file using the private spend key as the passphrase.
		 gpg --passphrase "$sk" -c $target_file ; # Encrypt the file.
		 srm $target_file # securely remove the source plaintext file.

	fi
fi
