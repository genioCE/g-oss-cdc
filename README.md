# g-oss-cdc · Change Data Capture & replication (Redpanda/Kafka + Connect + Debezium + Iceberg sink)

**Audience:** O&G CIOs/CTOs and data platform owners  
**Goal:** Replace proprietary CDC/replication (e.g., GoldenGate/Qlik Replicate) with open tooling that writes into Iceberg tables.

---

## Executive summary
- **What it is:** **Debezium** reads database logs (Postgres/SQL Server/Oracle*) and publishes row‑level changes to Kafka (here via **Redpanda**). **Kafka Connect** + **Iceberg Sink** commit those changes to **Iceberg tables**.  
- **What it replaces:** GoldenGate/Qlik Replicate/Informatica CDC feeding proprietary warehouses.  
- **Outcomes:** Real‑time freshness (<1–2 min), open formats, lower license spend, cleaner lineage and rollback.

\* Oracle CDC feasibility depends on privileges and edition—evaluate per system.

## Where it fits
```
[OLTP DB] --CDC--> Debezium -> Kafka topics -> Iceberg Sink -> [Iceberg tables in g-oss-core]
                                                         ^ schema registry (Apicurio)
```
Downstream consumers (Trino/dbt/GE) run in `g-oss-batch` + `g-oss-core`.

## O&G use cases
- **Well tests & production volumes** mirrored in near‑real‑time.  
- **Work orders / field tickets** for daily ops dashboards.  
- **Financial subledgers** (narrow scoped) for intraday reconciliation.

## What’s included
- **Redpanda** (Kafka API) + console.  
- **Kafka Connect** with **Debezium** source and **Iceberg Sink**.  
- **Postgres** sample source DB + seed script.  
- **Apicurio Registry** (schema control).

## Pilot SLOs (defaults)
- **End‑to‑end CDC latency:** P95 < 60s.  
- **Delivery success:** ≥ 99.5% with idempotent MERGE downstream.  
- **Schema compatibility:** enforced via registry, breaking changes blocked.

## Security & compliance
- Network‑isolated **read‑only** log access; no write paths to OLTP.  
- Credentials managed via Vault (see `g-oss-security`).  
- Immutable Iceberg history enables rollback and audit replay.

## Cost model
- Broker footprint scales with topics/throughput; compact retention for CDC keys.  
- No per‑connector licensing; engineer time for connectors + monitoring.

## Migration & rollout
1. **Shadow**: stand up CDC on 1–2 tables in read‑only mode.  
2. **Parallel**: run both legacy and new pipelines; compare counts/metrics.  
3. **Cutover**: repoint consumers to Iceberg tables; keep topics for rollback.

## KPIs for leadership
- Freshness (lag), delivery success, schema‑drift incidents, defects found via DQ gates, license spend eliminated.

## Risks & limits
- Oracle CDC requires careful setup; test privileges early.  
- Backfills: do an initial bulk snapshot then continue with CDC.

## Quick start
```bash
cp .env.example .env
docker compose up -d
bash scripts/init_connectors.sh
# Console: http://localhost:8080 • Connect: http://localhost:8083
```
