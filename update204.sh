#!/bin/bash

for ID in $(seq 1 30); do
  cd aztec-sequencer-ipnode-${ID}
  docker compose down 
  sed -i 's|aztecprotocol/aztec:[^"]*|aztecprotocol/aztec:2.0.4|' docker-compose.yml && \
  echo "GOVERNANCE_PROPOSER_PAYLOAD_ADDRESS=0xDCd9DdeAbEF70108cE02576df1eB333c4244C666" >> .env
  docker compose up -d
  cd
  sleep $(( RANDOM % 301 + 900 ))
done
