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
Please edit ./src/oxyak.json to point for your oxy-node (it's self explanatory).

Example usage below.

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
