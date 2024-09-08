FROM alpine:3.19

# Install MariaDB and necessary tools
RUN apk update && apk add --no-cache mariadb mariadb-client

# Set up the MySQL configuration for Docker environment
RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf

# Initialize the MariaDB database directory
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
RUN mkdir -p tmp

# Expose MariaDB port
EXPOSE 3306

# Copy initialization script to the container
COPY requirements/mariadb/conf/init_db.sh /docker-entrypoint-initdb.d/init_db.sh
RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

ENTRYPOINT ["/docker-entrypoint-initdb.d/init_db.sh"]
