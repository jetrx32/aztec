#!/bin/bash


PK=$1
BLS_PK=$2
ID=$3

cd aztec-sequencer-ipnode-${ID}
cp data/p2p-private-key p2p-private-key212bak
docker compose down -v
rm -rf data
mkdir data
cp p2p-private-key212bak data/p2p-private-key
sed -i 's|aztecprotocol/aztec:[^"]*|aztecprotocol/aztec:2.1.2|' docker-compose.yml && \
sed -i '/GOVERNANCE_PROPOSER_PAYLOAD_ADDRESS/d' .env
mv keys/keystore.json keystore.jsonbak
FEE_RECIPIENT=$(cat keystore.jsonbak | grep feeRecipient | cut -d'"' -f4)
wget -O keys/keystore.json https://raw.githubusercontent.com/jetrx32/aztec/refs/heads/main/keystore.json
sed -i 's/ETH_PK/'${PK}'/' keys/keystore.json
sed -i 's/BLS_PK/'${BLS_PK}'/' keys/keystore.json
sed -i 's/FEE_REC/'${FEE_RECIPIENT}'/' keys/keystore.json


docker compose up -d

