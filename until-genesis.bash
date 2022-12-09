# This script was initally written by a concerned friend
# we're deeply grateful
set -euxo pipefail

# clone the kujira repository
git clone https://github.com/Team-Kujira/core

# enter the repository
cd core || exit
make build


# create keys for testing
./core/build/kujirad --home data --keyring-backend test keys add validator
./core/build/kujirad --home data --keyring-backend test keys add admin
./core/build/kujirad --home data --keyring-backend test keys add owner
./core/build/kujirad --home data --keyring-backend test keys add user
./core/build/kujirad --home data --keyring-backend test keys add luser



# init a validator
./core/build/kujirad --home data init test-validator

# inspect genesis and ensure the network will start
cp data/config/genesis.json data/config/genesis.json.orig
nvim data/config/genesis.json
cp data/config/genesis.json data/config/genesis.json.fixup
