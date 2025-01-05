#!/bin/bash

# Wait for Debezium to start
echo "Waiting for Debezium to start... (30 sec)"
sleep 30

# Register the connector
curl -X POST -H "Content-Type: application/json" \
  --data '{
    "name": "pg-get-data-connector",
    "config": {
        "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
        "tasks.max": "1",
        "database.hostname": "postgres_master",
        "database.port": 5432,
        "database.user": "kafka_replica",
        "database.password": "kafka_replica",
        "database.dbname" : "postgres",
        "database.server.name": "db_pg_master",
        "plugin.name": "pgoutput",
        "table.include.list": "public.*",
        "publication.name": "dbz_publication",
        "poll.interval.ms": "1000",
        "heartbeat.action.query": "INSERT INTO debezium_info.heartbeat (date_load) VALUES (NOW());",
        "heartbeat.writeback.enabled": "true",
        "heartbeat.interval.ms": 5,
        "topic.prefix": "db_pg_master"
        }
    }' \
  http://localhost:8083/connectors
