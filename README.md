# Starting PostgreSQL Container with Replica
This README provides instructions on how to start the multi-container application. 

## Prerequisites
- Ensure you have up-to-date Docker installed on your machine.

## Starting the Container

### Default scenario
To start the PostgreSQL container with a replica, simply run the following command in your project directory:

bash:
```
./docker-init.sh
```
This script will handle the setup and configuration of all containers automatically.

### If everything breaks
If it for some reason fails 😢 - run the default docker compose command in the project directory:

bash:
```
docker compose up --build
```
(but replication from `postgres_master` -> `postgres_replica` will not work 😉 AND you will need to add `dwh_dds` and `db_analytical` connectors to Apache Airflow manually via the Airflow UI)

## Populating the PostgreSQL Master with Test Data
After starting the containers (startup script outputs "Done"), you can populate the postgres_master database with test data, check its replication and data upload into DWH DDS by executing the following command in your shell:

bash:
```
./dds/check_replication_and_dmp.sh
```

This command reads the contents of the populate_test_data.sql file and pipes it to the psql command running inside the postgres_master container, using the postgres user to connect to the postgres database. Then checks data in the table inside both `postgres_master`, `postgres_master` and `DWH DDS`.

## Running a Test Query
You can also run the task_view.sql script on the `postgres_master` to execute a test query (defined in the task). Use the following command:

bash:
```
cat ./source_db/task_view.sql | docker exec -i postgres_master psql -U postgres -d postgres
```
This command will execute the SQL statements contained in the task_view.sql file against the `postgres_master` database, allowing you to test your queries.

## Check Debezium connector writes to Kafka using Kafdrop UI
- `http://localhost:9000`

## Open Apache Airflow UI
- `http://localhost:8080`

Enable DAGs regular runs to launch ETL tasks loading data into `db_analytical`

## View analytical dashboards in Grafana UI
- `http://localhost:3000`

*(no Auth needed - disabled for dev purposes; dashboards and datasources are provisioned automatically)*

Also see `./dashboard_sample_views` directory for screenshots of ready dashboards (in case you encounter error loading the Grafana UI)
