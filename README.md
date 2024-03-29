# This project has been replaced with https://github.com/MoneroAuth

# Monero-Crypto-Lock
Programmable digital lock construct using a Monero wallet and commands.

Article describing Monero Crypto-Lock:
https://steemit.com/monero/@douglasbebber/monero-crypto-lock


# Dependencies
To use Monero Crypto-Lock you will need to download a current distribution of the Monero software.
The initial Monero Crypto-Lock project used the monero-v0.11.1.0 release. We just changed over to
monero-v0.12.3.0

1. Install the Monero software on your system.
2. Run the monerod daemon. You can run it with the --offline parameter to prevent having to sync with the blockchain.
3. Run the monero-wallet-rpc program. 
   Typical launch:
   
   ./monero-wallet-rpc --rpc-bind-port 18083 --disable-rpc-login --wallet-file /home/user/monero-v0.12.3.0/test --prompt
   
At this point, if everything runs properly, you should be able to start issuing jsonrpc commands.

# Browser extension for secure anonymous authentication
Video: https://gateway.ipfs.io/ipfs/QmP8HQMrw83LC8NvALpCU4gkwxZ45gpzCAB2GEd6JRTVJB

If you have trouble loading the video with IPFS, the video file is located in the browser extensions directory: https://github.com/monero-ecosystem/Monero-Crypto-Lock/blob/master/browser-extensions/MoneroAuth.mp4
You can download the video and watch it.


The source code for the Firefox and Chromium/Chrome browser extensions (alpha version) are now in the browser-extensions directory.

How-to install and run dependencies for the Monero Authentication browser extension:

https://gateway.ipfs.io/ipfs/QmVQbGzg9fBwCj491J3ZLYAE1K2m7NAhLycRZu1kXaG38x


# Demo Web Applications
A simple browser extension test app (on the clearnet) can be found at:http://23.92.31.84:3021/ 

There is a similar test app on the I2P network at: http://lrqks3cdoh5d6arrkng4njdbykveytbdzu4dl2tqizs7mnlwz7ka.b32.i2p/

You can use our browser extension with these test apps.

You must be on the I2P network to use the I2P test app.
