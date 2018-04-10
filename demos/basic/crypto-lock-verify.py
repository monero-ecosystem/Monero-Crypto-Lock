import sys
import os
import json
import requests

# Challenge string, address, and signature are passed as parameters
# on the command line. Each separated by a single space.
n = len(sys.argv)
if n < 4:
        print("a challenge string must be provided!")
        sys.exit()
challenge = sys.argv[1]
address = sys.argv[2]
signature = sys.argv[3]

# Now let's verify that the signature of the challenge was on behalf of
# the passed Monero address...
url = "http://localhost:18082/json_rpc"

headers = {'content-type': 'application/json'}
rpc_input2 = {
	"method": "verify",
	"params": {"data": challenge,
		   "address": address,
		   "signature": signature}
}
rpc_input2.update({"jsonrpc": "2.0", "id": "0"})
response2 = requests.post(url,data=json.dumps(rpc_input2),headers=headers)
sd = response2.json()
print(json.dumps(response2.json(), indent=4))
