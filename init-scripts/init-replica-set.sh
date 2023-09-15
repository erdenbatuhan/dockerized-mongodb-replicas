#!/bin/bash

# Run MongoDB replica initialization script
echo "Creating replica set ($MONGO_REPL_ID)"
mongosh --host "$MONGO_REPL_1" init-replica-set.js
echo "Replica set ($MONGO_REPL_ID) created"
