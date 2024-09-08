FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    bash \
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
    && apt-get clean

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY requirements/wordpress/conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN mkdir /run/php

COPY requirements/wordpress/tools/create_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wordpress.sh
ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]

