#!/bin/bash

set -euxo pipefail

# init a validator
./core/build/kujirad --home data init test-validator

# make accounts
./core/build/kujirad --home data --keyring-backend test keys add validator
./core/build/kujirad --home data --keyring-backend test keys add admin
./core/build/kujirad --home data --keyring-backend test keys add owner
./core/build/kujirad --home data --keyring-backend test keys add user
./core/build/kujirad --home data --keyring-backend test keys add luser

echo "validator" > addresses
./core/build/kujirad --home data --keyring-backend test keys show validator -a >> addresses
echo "admin" > addresses
./core/build/kujirad --home data --keyring-backend test keys show admin -a >> addresses
echo "owner" > addresses
./core/build/kujirad --home data --keyring-backend test keys show owner -a >> addresses
echo "user" > addresses
./core/build/kujirad --home data --keyring-backend test keys show user -a >> addresses
echo "luser" > addresses
./core/build/kujirad --home data --keyring-backend test keys show luser -a >> addresses


# inspect genesis and ensure the network will start
# basically change the denom to ukuji from "stake"
# also need to make gov pass really, really fast

	
sed -i '' 's/stake/ukuji/g' data/config/genesis.json
sed -i '' 's/172800s/60s/g' data/config/genesis.json

# add accounts to genesis
./core/build/kujirad --home data --keyring-backend test add-genesis-account validator 1000000000000ukuji
./core/build/kujirad --home data --keyring-backend test add-genesis-account admin      100000000000ukuji
./core/build/kujirad --home data --keyring-backend test add-genesis-account user       100000000000ukuji
./core/build/kujirad --home data --keyring-backend test add-genesis-account owner      100000000000ukuji
./core/build/kujirad --home data --keyring-backend test add-genesis-account luser      100000000000ukuji


# create a genesis transaction
./core/build/kujirad --home data --keyring-backend test gentx validator 500000000000ukuji --chain-id kujira


# collect the genesis transaction
./core/build/kujirad --home data collect-gentxs

# check genesis to ensure that it is valid
./core/build/kujirad --home data validate-genesis

# start a single node test network
./core/build/kujirad --home data start

