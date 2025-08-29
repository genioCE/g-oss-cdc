# g-oss-cdc

CDC: **Redpanda/Kafka + Kafka Connect (Debezium + Iceberg sink) + Apicurio + Postgres source**.

## Run
```bash
cp .env.example .env
docker compose up -d
bash scripts/init_connectors.sh
```
- Redpanda Console: http://localhost:8080
- Kafka Connect: http://localhost:8083
- Apicurio Registry: http://localhost:8085
