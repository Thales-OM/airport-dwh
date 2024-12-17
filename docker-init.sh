# TODO: get rid of waiting - implement healthcheck + depends_on for all containers

echo "Stopping and clearing volume data"
docker-compose down -v

echo "Starting postgres_master node..."
docker-compose up -d postgres_master

echo "Waiting for postgres_master to be ready... (30 sec)"
sleep 30

echo "Prepare replica config..."
docker exec -it postgres_master sh /etc/postgresql/init-script/init.sh

echo "Restart master node"
docker-compose restart postgres_master

echo "Waiting for master node to start... (30 sec)"
sleep 30

echo "Starting replica node..."
docker-compose up -d postgres_replica

echo "Waiting for replica node to start... (30 sec)"
sleep 30

docker-compose up -d zookeeper

docker-compose up -d kafka

docker-compose up -d debezium

sh ./debezium/connector-setup.sh

docker-compose up -d kafdrop

echo "Done"
