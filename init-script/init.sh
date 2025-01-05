#!/bin/bash
set -e

echo "Creating replica user"
sh /etc/postgresql/init-script/create-replica-user.sh

echo "Creating backup master"
sh /etc/postgresql/init-script/backup-master.sh

echo "Initializing replica"
sh /etc/postgresql/init-script/init-replica.sh

# echo "Restarting"
# pg_ctl restart -D /var/lib/postgresql/data

# docker-entrypoint.sh postgres