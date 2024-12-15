#!/bin/bash

# Wait for Debezium to start
sleep 30

# Register the connector
curl -X POST -H "Content-Type: application/json" \
  --data '{
    "name": "postgres-connector",
    "config": {
      "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
      "tasks.max": "1",
      "database.hostname": "'"$DEBEZIUM_POSTGRES_SERVICE"'",
      "database.port": "'"$DEBEZIUM_POSTGRES_PORT"'",
      "database.user": "'"$DEBEZIUM_POSTGRES_USER"'",
      "database.password": "'"$DEBEZIUM_POSTGRES_PASSWORD"'",
      "database.dbname": "'"$DEBEZIUM_POSTGRES_DB"'",
      "database.server.name": "dbserver1",
      "table.include.list": "public.*",  # Track all tables in the public schema
      "plugin.name": "pgoutput",
      "snapshot.mode": "initial"  # or "schema_only" to only track changes from now on
    }
  }' \
  http://localhost:8083/connectors


curl -X POST -H "Content-Type: application/json" \
  --data '{
    "name": "postgres-connector1",
    "config": {
      "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
      "tasks.max": "1",
      "database.hostname": "postgres_master",
      "database.port": "5432",
      "database.user": "postgres",
      "database.password": "postgres",
      "database.dbname": "postgres",
      "database.server.name": "dbserver1",
      "schema.include.list": "public",
      "plugin.name": "pgoutput",
      "snapshot.mode": "initial",
      "topic.prefix": "postgres_master"
    }
  }' \
  http://localhost:8083/connectors