# Monero-Crypto-Lock
Programmable digital lock construct using a Monero wallet and commands.

Article describing Monero Crypto-Lock:
https://steemit.com/monero/@douglasbebber/monero-crypto-lock


# Dependencies
To use Monero Crypto-Lock you will need to download a current distribution of the Monero software.
The initial Monero Crypto-Lock project used the monero-v0.11.1.0 release. We just changed over to
monero-v0.12.0.0

1. Install the Monero software on your system.
2. Run the monerod daemon. You can run it with the --offline parameter to prevent having to sync with the blockchain.
3. Run the monero-wallet-rpc program. 
   Typical launch:
   
   ./monero-wallet-rpc --rpc-bind-port 18083 --disable-rpc-login --wallet-file /home/user/monero-v0.12.0.0/test --prompt
   
At this point, if everything runs properly, you should be able to start issuing jsonrpc commands.

# Browser extension for secure anonymous authentication
Video: https://gateway.ipfs.io/ipfs/QmP8HQMrw83LC8NvALpCU4gkwxZ45gpzCAB2GEd6JRTVJB

also available at: https://d.tube/#!/v/douglasbebber/8xw6fk2e

The source code for the Firefox browser extension (alpha version) is now in the browser-extensions directory under Firefox.
Documentation and howto videos for users and developers will be available soon.
