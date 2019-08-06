FROM debian:stretch-slim

LABEL maintainer "dm <dmitrij.demidovich@gmail.com>"

RUN set -xe \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data \
    #
    # 1. Пакеты для скачивания
    #
    && apt update \
    && apt-get -y --no-install-recommends --no-install-suggests install \
        ca-certificates \
        apt-transport-https \
        wget \
    #
    # 2. Репозиторий PHP
    #
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list \
    && apt update

    #
    # 3. PHP
    # amqp - расширение pear быстрее и экономичнее, чем библиотека amqplib
    #
RUN apt-get -y --no-install-recommends --no-install-suggests install \
        php7.3 \
        php7.3-fpm \
        php7.3-cli \
        php7.3-common \
        php7.3-opcache \
        php7.3-curl \
        php7.3-mbstring \
        php7.3-mysql \
        php7.3-pgsql \
        php7.3-xml \
        php7.3-bcmath \
        php7.3-intl \
        php7.3-json \
        php7.3-zip \
        php7.3-gd \
        php-redis \
        php-amqp \
        php-sodium \
    #
    # 4. Процедуры после установки
    #
    && ln -s /usr/sbin/php-fpm7.3 /usr/sbin/php-fpm \
    && apt-get -y purge \
        wget \
    && apt-get -y autoremove --purge \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

    # RabbitMQ
    # amqp - расширение pear быстрее и экономичнее, чем библиотека amqplib

# EXPOSE 9000
# WORKDIR /app
# CMD [ "php-fpm", "--nodaemonize" ]
