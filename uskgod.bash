# get our validator address, see if it is ready to rock
./core/build/kujirad query account "$(./core/build/kujirad --home data --keyring-backend test keys show validator -a)"

./core/build/kujirad --home data --keyring-backend test tx wasm store contract/code-11.wasm --from admin --gas auto -y --broadcast-mode block --gas-adjustment 3

./core/build/kujirad --home data --keyring-backend test tx gov submit-proposal instantiate-contract 1 '{"owner": "kujira1k8wkclcx3w6rgxhxjzq4dvv0yy5z2qxdfjhphk", "denom": "uusk" }' --label "USK Controller" --title  "Deploy the USK Controller Contract" --description  "The USK protocol will have multiple markets that use multiple collateral types to mint USK. This contract acts as a simple controller, accessing the underlying denom module from the chain core; authorizing each individual market and routing messages to mint and burn USK" --run-as kujira1k8wkclcx3w6rgxhxjzq4dvv0yy5z2qxdfjhphk --admin kujira1k8wkclcx3w6rgxhxjzq4dvv0yy5z2qxdfjhphk --amount 10000000000ukuji --from kujira1k8wkclcx3w6rgxhxjzq4dvv0yy5z2qxdfjhphk --gas auto -y --broadcast-mode block --gas-adjustment 3

./core/build/kujirad --home data --keyring-backend test tx gov deposit 1 10000000000ukuji --from validator --broadcast-mode block -y

./core/build/kujirad --home data --keyring-backend test tx gov vote 1 yes  --from validator --broadcast-mode block -y


./core/build/kujirad --home data query wasm list-contract-by-code 1

# kujira14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sl4e867


# bless one address with special privileges
./core/build/kujirad --home data --keyring-backend test tx wasm execute kujira14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sl4e867 '{ "permit": { "address": "kujira17erm3xmpuz45rcyrnc4n32hweyqjykragdvl8q" } }' --from owner  --broadcast-mode block -y

# mint usk without collateral
./core/build/kujirad --home data --keyring-backend test tx wasm execute kujira14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sl4e867 '{"mint": {"amount": "10000", "recipient": "kujira1fdsjfm3pfhn6fs227vz98xtzs2qtkpvt545jhg"}}' --from user  --broadcast-mode block -y

# show balances
./core/build/kujirad --home data query bank balances "$(./core/build/kujirad --home data --keyring-backend test keys show luser -a)"

