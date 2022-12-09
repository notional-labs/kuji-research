# Kujira threat report

https://t.co/X04x2JBcWT

## Produced for the Cosmos community by Notional Labs

This repository can be used to conclusively confirm that the USK "fully collateralized stablecoin" can be arbitarily minted by the contract admin.

I think there is a lot more, too.

## Using this repository to confirm infinite mint

First run a node like:

```bash
bash prepare-node.bash
```

this will create the "addresses" file.  you then need to modify the addresses found in uskgod.bash

after that, this demonstrates the infinite mint of the "fully collateralized stablecoin" usk.

## Original script from a friend

Note that you need to change the denom name from stake to ukuji in genesis.json and you also will need to make sure that gov props are dramatically shortened, I went with 60s.

This repository contains a wasm contract sourced directly from a polkachu endpoint on the kujira mainnet.

```bash

git clone git@github.com:Team-Kujira/core.git

(cd core && make build)

./core/build/kujirad --home data --keyring-backend test keys add validator
./core/build/kujirad --home data --keyring-backend test keys add admin
./core/build/kujirad --home data --keyring-backend test keys add owner
./core/build/kujirad --home data --keyring-backend test keys add user
./core/build/kujirad --home data --keyring-backend test keys add luser

./core/build/kujirad --home data init test-validator

cp data/config/genesis.json data/config/genesis.json.orig
nvim data/config/genesis.json
cp data/config/genesis.json data/config/genesis.json.fixup


./core/build/kujirad --home data --keyring-backend test add-genesis-account validator 1000000000000ukuji
./core/build/kujirad --home data --keyring-backend test add-genesis-account admin      100000000000ukuji
./core/build/kujirad --home data --keyring-backend test add-genesis-account user       100000000000ukuji
./core/build/kujirad --home data --keyring-backend test add-genesis-account owner      100000000000ukuji

./core/build/kujirad --home data --keyring-backend test gentx validator 500000000000ukuji --chain-id kujira

./core/build/kujirad --home data collect-gentxs
./core/build/kujirad --home data validate-genesis
./core/build/kujirad --home data start


./core/build/kujirad query account $(./core/build/kujirad --home data --keyring-backend test keys show validator -a)


./core/build/kujirad --node https://kujira-rpc.polkachu.com:443 query wasm list-contract-by-code 11

./core/build/kujirad --node https://kujira-rpc.polkachu.com:443 query wasm contract kujira1qk00h5atutpsv900x202pxx42npjr9thg58dnqpa72f2p7m2luase444a7

./core/build/kujirad --node https://kujira-rpc.polkachu.com:443 query wasm code 11 code-11.wasm

./core/build/kujirad --home data --keyring-backend test tx wasm store code-11.wasm --from admin --gas auto -y --broadcast-mode block --gas-adjustment 3


./core/build/kujirad --node https://kujira-rpc.polkachu.com:443 query gov proposal 35

./core/build/kujirad --node https://kujira-rpc.polkachu.com:443 query gov proposal 35 -o json | jq > proposal.

./core/build/kujirad --home data --keyring-backend test tx gov submit-proposal instantiate-contract 1 '{"owner": "kujira1qwdq29e43f4gpr3d0m7sl88a5n29pnwz3g5tc0", "denom": "uusk" }' --label "USK Controller" --title  "Deploy the USK Controller Contract" --description  "The USK protocol will have multiple markets that use multiple collateral types to mint USK. This contract acts as a simple controller, accessing the underlying denom module from the chain core; authorizing each individual market and routing messages to mint and burn USK" --run-as kujira1v7d5j88ytcu4940xrh70nj9ktkyvv0xrwzfjmc --admin kujira1v7d5j88ytcu4940xrh70nj9ktkyvv0xrwzfjmc --amount 10000000000ukuji --from admin --gas auto -y --broadcast-mode block --gas-adjustment 3

./core/build/kujirad --home data --keyring-backend test tx gov deposit 1 10000000000ukuji --from validator --broadcast-mode block -y

./core/build/kujirad --home data --keyring-backend test tx gov vote 1 yes  --from validator --broadcast-mode block -y

./core/build/kujirad --home data query wasm list-contract-by-code 1

# kujira14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sl4e867

./core/build/kujirad --home data --keyring-backend test tx wasm execute kujira14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sl4e867 '{ "permit": { "address": "kujira17erm3xmpuz45rcyrnc4n32hweyqjykragdvl8q" } }' --from owner  --broadcast-mode block -y


./core/build/kujirad --home data --keyring-backend test tx wasm execute kujira14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sl4e867 '{"mint": {"amount": "10000", "recipient": "kujira1fdsjfm3pfhn6fs227vz98xtzs2qtkpvt545jhg"}}' --from user  --broadcast-mode block -y

./core/build/kujirad --home data query bank balances $(./core/build/kujirad --home data --keyring-backend test keys show luser -a)
```
