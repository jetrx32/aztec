#!/bin/bash

for ID in $(seq 1 30); do
  cd aztec-sequencer-ipnode-${ID}
  docker compose down 
  sed -i 's|aztecprotocol/aztec:[^"]*|aztecprotocol/aztec:2.1.2|' docker-compose.yml && \
  sed -i '/GOVERNANCE_PROPOSER_PAYLOAD_ADDRESS/d' .env
  docker compose up -d
  cd
  sleep $(( RANDOM % 301 + 600 ))
done
