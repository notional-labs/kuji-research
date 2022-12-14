#!/bin/bash


# This file gathers contracts from the kujira mainnet and can be used to reproduce findings


# get contract 11 from kujira mainnet
./core/build/kujirad --node https://kujira-rpc.polkachu.com:443 query wasm list-contract-by-code 11

# query mainnet contract 
./core/build/kujirad --node https://kujira-rpc.polkachu.com:443 query wasm contract kujira1qk00h5atutpsv900x202pxx42npjr9thg58dnqpa72f2p7m2luase444a7

# save contract 11 to code-11.wasm 
./core/build/kujirad --node https://kujira-rpc.polkachu.com:443 query wasm code 11 contract/code-11.wasm

# get proposal 35 from kujira mainnet and save it to proposal.json
./core/build/kujirad --node https://kujira-rpc.polkachu.com:443 query gov proposal 35 -o json | jq > proposal.json