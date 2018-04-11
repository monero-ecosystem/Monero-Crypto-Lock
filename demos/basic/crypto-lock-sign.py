import sys
import json
import requests

# Challenge string is passed as a parameter on the command line.
n = len(sys.argv)
if n == 1:
        print("a challenge string must be provided!")
        sys.exit()
challenge = sys.argv[1]

# First we will get the Monero address...
url = "http://localhost:18082/json_rpc"

headers = {'content-type': 'application/json'}

rpc_input = {
	"method": "getaddress"
}

rpc_input.update({"jsonrpc": "2.0", "id": "0"})

response = requests.post(url,data=json.dumps(rpc_input),headers=headers)
jd = response.json()
address = jd["result"]["address"]
print("Challenge: " + challenge)
print("Address: " + address)

# Now let's sign the challenge...
rpc_input2 = {
	"method": "sign",
	"params": {"data": challenge}
}
rpc_input2.update({"jsonrpc": "2.0", "id": "0"})
response2 = requests.post(url,data=json.dumps(rpc_input2),headers=headers)
sd = response2.json()
signature = sd["result"]["signature"]
print("Signature: " + signature)

