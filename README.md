# Starting PostgreSQL Container with Replica
This README provides instructions on how to start a PostgreSQL container with a replica and populate the master database with test data.

## Prerequisites
- Ensure you have Docker installed on your machine.
- Make sure the docker-init.sh script and the SQL files (populate_test_data.sql and task_view.sql) are available in your project directory.

## Starting the Container
To start the PostgreSQL container with a replica, simply run the following command in your project directory:

bash:
```
./docker-init.sh
```

This script will handle the setup and configuration of all containers automatically.

## Populating the PostgreSQL Master with Test Data
After starting the containers, you can populate the postgres_master database with test data and check its replication by executing the following command in your shell:

bash:
```
./source_db/check_replication.sh
```

This command reads the contents of the populate_test_data.sql file and pipes it to the psql command running inside the postgres_master container, using the postgres user to connect to the postgres database. Then check data in the table inside both master ad replica.

## Running a Test Query
You can also run the task_view.sql script on the postgres_master to execute a test query. Use the following command:

bash:
```
cat ./source_db/task_view.sql | docker exec -i postgres_master psql -U postgres -d postgres
```
This command will execute the SQL statements contained in the task_view.sql file against the postgres_master database, allowing you to test your queries.

## Check Debezium connector writes to Kafka using Kafdrop UI
- `http://localhost:9000`
