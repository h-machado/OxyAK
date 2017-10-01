# OxyAK
Oxy Army Knife - Forging failover and command line Oxy

## Install

Requires access to an Oxy-node API.

If you have Oxy-node installed, just install OxyAK at the same host.

```
git clone https://github.com/h-machado/OxyAK.git
npm install
#edit ./src/oxyak.json
./oxyak.sh --help
```

## Usage

### Failover forging and node monitoring
![OxyAK proposed setup for monitoring](https://github.com/h-machado/OxyAK/blob/master/docs/oxyak_proposed_setup.jpg)

OxyAK running with the failoverMonkey flag will always try to have forging enabled at the best possible node using always forge tactics inspired by [lisk army knife](https://github.com/filipealmeida/liskak):
* Flag: ```-Q 51 2``` -> don't switch to better consensus if consensus is above 51%
* Flag: ```-D 2``` -> don't switch to better height if height of current forging node is under 2 of difference

Example:

```
someuser@foo:~/oxyak$ ./oxyak.sh -c /home/foo/my_forger_configuration.json -f http://172.17.0.2:8000 http://172.17.0.3:8000 http://172.17.0.4:8000 -P 3000 -w 3000
2017-01-02T20:43:34.498Z INFO Initializing
2017-01-02T20:43:34.504Z INFO Failover monkey starting: ["http://172.17.0.2:8000","http://172.17.0.3:8000","http://172.17.0.4:8000"]
2017-01-02T20:43:34.505Z INFO Enabling monitor for node http://172.17.0.2:8000
2017-01-02T20:43:34.506Z INFO Enabling monitor for node http://172.17.0.3:8000
2017-01-02T20:43:34.506Z INFO Enabling monitor for node http://172.17.0.4:8000
2017-01-02T20:43:37.508Z INFO Probe cycle 0
2017-01-02T20:43:37.549Z INFO Evaluation cycle 0
2017-01-02T20:43:37.549Z WARN Server http://172.17.0.3:8000/ removed from forge failover list (syncing or failed)
2017-01-02T20:43:37.550Z WARN Server http://172.17.0.4:8000/ removed from forge failover list (syncing or failed)
2017-01-02T20:43:37.550Z INFO Iteration 1: best server is: http://172.17.0.2:8000/
2017-01-02T20:43:37.550Z INFO Warming up, no action; Forge failover will be active in 2 cycles
2017-01-02T20:43:37.551Z INFO Forging is ENABLED at http://172.17.0.2:8000/
......
2017-01-02T20:44:58.307Z INFO Evaluation cycle 24
2017-01-02T20:44:58.307Z WARN Server http://172.17.0.3:8000/ removed from forge failover list (syncing or failed)
2017-01-02T20:44:58.307Z WARN Server http://172.17.0.4:8000/ removed from forge failover list (syncing or failed)
2017-01-02T20:44:58.307Z INFO Iteration 25: best server is: http://172.17.0.2:8000/
2017-01-02T20:44:58.307Z INFO Summary: http://172.17.0.4:8000/[-] http://172.17.0.3:8000/[-] http://172.17.0.2:8000/[*]
......
```

Additional usage of this can be found in the bundled scripts, `monitorMain.sh` and `monitorTest.sh`. These files include everything needed to enable forging monitoring.

Each script has an associated config file, `oxyak_testnet.json` and `oxyak_mainnet.json` in the `src/` folder. Simply add the delegate secret you wish you monitor to that file.
Then edit the monitoring script for the network you will be monitoring and include your hosts.

Example:

```
HOST1="http://127.0.0.1:8000"
HOST2=""
HOST3=""
HOST4=
CONFIG="src/oxyak_mainnet.json"
LOG_FILE="logs/forgingMain.log"
pkill -f $CONFIG -9
nohup bash oxyak.sh -c $CONFIG -f $HOST1 $HOST2 $HOST3 $HOST4 > $LOG_FILE 2>&1&
```

Using mainnet as an example, the script using `bash monitorMain.sh`. The logs for this will be found in `logs/`, this can be watched to see the monitoring in action.


Please edit ./src/oxyak.json to point for your oxy-node (it's self explanatory).

### Get a new account
```
u@h:~/OxyAK$ ./oxyak.sh -Ni -c ./src/oxyak.json 
New account passphrase is: "future blade dumb limb shock robot fruit crane omit toy dismiss neutral"
xprivate: "xprv9s21ZrQH143K311rcpUnVnzQXPR2kbraqJAyRD6wzevstHYWZEfy8khqCpsLix4GPKCHqbvwHWfdg7GThed8M9ySAk4d1YwxZEXwekS9R6D"
2017-09-25T14:56:22.655Z INFO Initializing
Oxy account info for /home/u/code/OxyAK/./src/oxyak.json
   address = 3411624220029535382X
   unconfirmedBalance = 0
   balance = 0
   publicKey = 8f76c7e620c826173092ade797640ec103e2be7fad0ecf23e967bc89efd8c44f
   unconfirmedSignature = 0
   secondSignature = 0
   secondPublicKey = null
   multisignatures = null
   u_multisignatures = null

```
Please don't use the secret present up there, it's for example purposes only

# Docker file

Test run
```
$ docker build -t oxy-testnet .
$ docker run -it -p 9998:9998 oxy-testnet and then cd /home/oxy/oxy-node && ./oxy_manager.bash rebuild

```
