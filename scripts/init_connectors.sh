#!/usr/bin/env bash
set -euo pipefail
curl -s -X PUT -H 'Content-Type: application/json' --data @connect/connectors/debezium-postgres-source.json http://localhost:8083/connectors/debezium-postgres-source/config | jq .
curl -s -X PUT -H 'Content-Type: application/json' --data @connect/connectors/iceberg-sink.json http://localhost:8083/connectors/iceberg-sink/config | jq .
