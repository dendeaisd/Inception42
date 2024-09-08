#!/bin/sh

# Debugging output
echo "MYSQL_DATABASE: $MYSQL_DATABASE"
echo "MYSQL_USER: $MYSQL_USER"
echo "MYSQL_PASSWORD: $MYSQL_PASSWORD"
echo "MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD"

DB_DIR=/tmp/create_db.sql

# Check if any variables are empty
if [ -z "$MYSQL_DATABASE" ] || [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ] || [ -z "$MYSQL_ROOT_PASSWORD" ]; then
  echo "One or more environment variables are missing"
  exit 1
fi

# Create the SQL commands
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"                        > $DB_DIR
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $DB_DIR
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"          >> $DB_DIR
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"        >> $DB_DIR
echo "FLUSH PRIVILEGES;"                                              >> $DB_DIR

# Start MariaDB in safe mode to run the initial SQL commands
mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking --socket=/run/mysqld/mysqld.sock &

# Wait for MariaDB to start
sleep 5

# Run the SQL commands from the SQL file
mysql -u root --socket=/run/mysqld/mysqld.sock < $DB_DIR

# Stop MariaDB
mysqladmin -u root -p $MYSQL_ROOT_PASSWORD --socket=/run/mysqld/mysqld.sock shutdown

# Start MariaDB with network access enabled
mariadbd --user=mysql --bind-address=0.0.0.0
