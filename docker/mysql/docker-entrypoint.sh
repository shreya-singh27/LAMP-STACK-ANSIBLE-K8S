#!/bin/bash
set -e
DATADIR=/var/lib/mysql
# init if empty
if [ ! -d "$DATADIR/mysql" ]; then
  echo "Initializing MariaDB data..."
  mysqld --initialize-insecure --user=mysql --datadir="$DATADIR" || true
  mysqld_safe --datadir="$DATADIR" & 
  pid="$!"
  sleep 5
  # set root password and create DB/user (env defaults)
  MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD:-rootpass}"
  MYSQL_DATABASE="${MYSQL_DATABASE:-appdb}"
  MYSQL_USER="${MYSQL_USER:-appuser}"
  MYSQL_PASSWORD="${MYSQL_PASSWORD:-apppass}"
  mysql --protocol=socket -uroot <<-EOSQL
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL
  mysqladmin --protocol=socket -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown || true
fi
exec mysqld_safe --datadir="$DATADIR"

