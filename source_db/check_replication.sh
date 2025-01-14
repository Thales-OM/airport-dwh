echo "Populate master with data"
cat ./source_db/populate_test_data.sql | docker exec -i postgres_master psql -U postgres -d postgres

echo "Check table in master"
cat ./source_db/check_table.sql | docker exec -i postgres_master psql -U postgres -d postgres

echo "Check replication to slave"
cat ./source_db/check_table.sql | docker exec -i postgres_replica psql -U postgres -d postgres 

echo "DMP working (mock)"
cat ./dds/populate_mock_data.sql | docker exec -i dwh_dds psql -U postgres -d postgres

echo "Check DDS contents"
cat ./dds/check_table.sql | docker exec -i dwh_dds psql -U postgres -d postgres