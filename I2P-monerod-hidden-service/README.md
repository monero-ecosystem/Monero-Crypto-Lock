This directory contains information regarding I2P monerod Hidden Service.

An I2P monerod Hidden Service provides a Monero full node interface that enables an anonymous, end-to-end encrypted network connection for Monero transacting clients (Monero wallet users can transact with the Monero blockchain anonymously and will not expose their IP addresses)

The updated pdf (dated 24 June 2019) has:


Added instructions for using an encrypted leaseset for the I2P monerod hidden service

Added instructions for automating services using systemd

Added instructions for use of VPN on monerod instance connection to the Internet

Opinion on Monero and Anonymous Network Transport Options

The official source of information (provided by the anonymous author of this paper) can be found at:

http://monerod.i2p

(You must be on the I2P network to resolve the above link!)
=====================================================================================================================

June 2019 - The author of the paper has made a test I2P monerod Hidden Service available for evaluation.
DO NOT TRY TO SEND ANY MONERO THROUGH THIS TEST SERVICE AS THE monerod IS RUNNING IN OFFLINE MODE!
(./monerod --offline)
The test serice is just for evaluation, connecting wallets to a running I2P monerod Hidden Service to see how it works.
Once you have a client I2P tunnel connecting to the test I2P monerod Hidden Service you can issue monerod daemon commands:

https://web.getmonero.org/resources/developer-guides/daemon-rpc.html

The test I2P Monerod Hidden Service destination is provided at: http://monerod.i2p

at the time of this post the Destination is: ylvyjddi5juw54qbkx7zelkujnhsvkukev6ncl6ec3gzhymwld2a.b32.i2p
