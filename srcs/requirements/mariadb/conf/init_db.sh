#!/bin/sh

# Ensure MySQL directory is properly owned by the mysql user
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MySQL data directory..."
    
    # Ensure the ownership of the MySQL directory is correct
    chown -R mysql:mysql /var/lib/mysql

    # Initialize the MySQL data directory
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

    # Temporary file for further checks
    tfile=$(mktemp)
    if [ ! -f "$tfile" ]; then
        echo "Temporary file creation failed. Exiting."
        exit 1
    fi
fi

# Check if the WordPress database already exists
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
    echo "Creating the WordPress database and setting up users..."

    # Create SQL file for initializing the database
    cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;

# Remove unnecessary users and test databases
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

# Set root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';

# Create WordPress database and user
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';

# Apply changes
FLUSH PRIVILEGES;
EOF

    # Run the SQL script
    /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql

    # Clean up the SQL script
    rm -f /tmp/create_db.sql
else
    echo "Database ${DB_NAME} already exists, skipping creation."
fi

echo "MySQL and WordPress database setup complete."
