FROM debian:bullseye-slim

ARG DB_NAME
ARG DB_USER
ARG DB_PASS

# Update package lists and install necessary packages
RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysqli \
    php-json \
    php-curl \
    php-dom \
    php-exif \
    php-fileinfo \
    php-mbstring \
    php-xml \
    php-zip \
    php-redis \
    wget \
    unzip \
    && apt-get clean

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php/*/fpm/pool.d/www.conf \
    && sed -i "s|;listen.owner = www-data|listen.owner = www-data|g" /etc/php/*/fpm/pool.d/www.conf \
    && sed -i "s|;listen.group = www-data|listen.group = www-data|g" /etc/php/*/fpm/pool.d/www.conf

# Set the working directory to /var/www
WORKDIR /var/www

# Download and set up WordPress
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip

# Copy custom WordPress configuration script
COPY ./requirements/wordpress/conf/wp-config-create.sh .

# Run the configuration script and set proper permissions
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    chmod -R 0777 wp-content/

EXPOSE 9000

CMD ["php-fpm", "-F", "-R"]
