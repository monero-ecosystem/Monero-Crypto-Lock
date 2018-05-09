# Browser Extensions
We currently provide two specific extensions for:

Mozilla Firefox

Chromium and Google Chrome

Video: https://gateway.ipfs.io/ipfs/QmP8HQMrw83LC8NvALpCU4gkwxZ45gpzCAB2GEd6JRTVJB

also available at: https://d.tube/#!/v/douglasbebber/8xw6fk2e
 
These browser extensions are provided for the purpose of enabling secure and anonymous authentication to web sites.
Since the objective is secure, anonymous authentication, our focus has been on development using i2p web sites. 

Authentication over the clearnet, exposes IP addresses and presents many risks to anonymity. In preparation for the 
Monero community adoption of Kovri, we want to begin using i2p out-of-the-gate. However, we have also created a 
Chrome browser for secure authentication over the Internet using a Monero wallet without having to use usernames 
and passwords. While this is not a pattern for securing anonymity, it does provide an approach to secure authentication
without users having to remember usernames and passwords.

# Dependencies
You will need to have monero-wallet-rpc running and available via one of your local ports.
The monero-wallet-rpc will need to be able to connect to a running instance of monerod.

If your only using monerod and monero-wallet-rpc for authentication purposes, it is recommended that you start
monerod with the --offline parameter. Then you will not need to deal with managing an updated blockchain. It is
also recommended that you use a new (empty) wallet for authentication usage. Create a new wallet and do not place
any XMR in that wallet.
