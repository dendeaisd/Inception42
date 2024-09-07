FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysqli \
    php7.4-json \
    php7.4-curl \
    php7.4-dom \
    php7.4-exif \
    php7.4-fileinfo \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
    php-redis \
    wget \
    unzip \
    && apt-get clean

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php/7.4/fpm/pool.d/www.conf \
    && sed -i "s|;listen.owner = www-data|listen.owner = www-data|g" /etc/php/7.4/fpm/pool.d/www.conf \
    && sed -i "s|;listen.group = www-data|listen.group = www-data|g" /etc/php/7.4/fpm/pool.d/www.conf

WORKDIR /var/www

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

CMD ["php-fpm7.4", "-F", "-R"]
