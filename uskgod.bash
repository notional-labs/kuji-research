validator
kujira1den9z5gfvune2s9mg7keur0yquphus8nnsvaz9
admin
kujira1287cgyndn3zex2rse430rtkun9fy33k2ryh6gd
owner
kujira1n96vahc78pglyp2ggd9apcrk3gtlwr0szh6lk4
user
kujira14zyne6zdnavsff8detwap43t43j9nfcwpatld2
luser
kujira1g3f9cswjqcuq7gnek6ztg44wfg33spkstsv9hc




# get our validator address, see if it is ready to rock
./core/build/kujirad query account "$(./core/build/kujirad --home data --keyring-backend test keys show validator -a)"

./core/build/kujirad --home data --keyring-backend test tx wasm store contract/code-11.wasm --from admin --gas auto -y --broadcast-mode block --gas-adjustment 3

./core/build/kujirad --home data --keyring-backend test tx gov submit-proposal instantiate-contract 1 '{"owner": "kujira1287cgyndn3zex2rse430rtkun9fy33k2ryh6gd", "denom": "uusk" }' --label "USK Controller" --title  "Deploy the USK Controller Contract" --description  "The USK protocol will have multiple markets that use multiple collateral types to mint USK. This contract acts as a simple controller, accessing the underlying denom module from the chain core; authorizing each individual market and routing messages to mint and burn USK" --run-as kujira1287cgyndn3zex2rse430rtkun9fy33k2ryh6gd --admin kujira1287cgyndn3zex2rse430rtkun9fy33k2ryh6gd --amount 10000000000ukuji --from kujira1287cgyndn3zex2rse430rtkun9fy33k2ryh6gd --gas auto -y --broadcast-mode block --gas-adjustment 3

./core/build/kujirad --home data --keyring-backend test tx gov deposit 1 10000000000ukuji --from validator --broadcast-mode block -y

./core/build/kujirad --home data --keyring-backend test tx gov vote 1 yes  --from validator --broadcast-mode block -y


./core/build/kujirad --home data query wasm list-contract-by-code 1

# kujira14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sl4e867


# bless one address with special privileges
./core/build/kujirad --home data --keyring-backend test tx wasm execute kujira14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sl4e867 '{ "permit": { "address": "kujira1287cgyndn3zex2rse430rtkun9fy33k2ryh6gd" } }' --from kujira1287cgyndn3zex2rse430rtkun9fy33k2ryh6gd  --broadcast-mode block -y

# mint usk without collateral
./core/build/kujirad --home data --keyring-backend test tx wasm execute kujira14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sl4e867 '{"mint": {"amount": "10000000", "recipient": "kujira14zyne6zdnavsff8detwap43t43j9nfcwpatld2"}}' --from kujira1287cgyndn3zex2rse430rtkun9fy33k2ryh6gd  --broadcast-mode block -y
# ./core/build/kujirad --home data --keyring-backend test tx wasm execute kujira14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sl4e867 '{"burn": {"amount": "100000", "to": "kujira14zyne6zdnavsff8detwap43t43j9nfcwpatld2"}}' --from kujira1287cgyndn3zex2rse430rtkun9fy33k2ryh6gd  --broadcast-mode block -y



# show balances
./core/build/kujirad --home data query bank balances "$(./core/build/kujirad --home data --keyring-backend test keys show luser -a)"


