FROM ubuntu:bionic

LABEL maintainer="dm <dmitrij.demidovich@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

#
# 1. Репозиторий PHP
#    Ставим без apt-add-repository, он раздует систему на 30Mb
#
RUN set -xe \
    && apt-get update \
    && apt-get -y --no-install-recommends --no-install-suggests install \
        ca-certificates \
        apt-transport-https \
        gnupg1 \
    && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main" >> /etc/apt/sources.list.d/php.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C \
    && apt-get update

#
# 2. PHP
#    amqp - расширение pear быстрее и экономичнее, чем библиотека amqplib
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
        php-sodium

#
# 3. Процедуры после установки
#
RUN ln -s /usr/sbin/php-fpm7.3 /usr/sbin/php-fpm \
    && apt-get -y --purge remove \
        gnupg1 \
#        `apt-mark showauto` \
    && apt-get -y autoremove --purge \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

    # RabbitMQ
    # amqp - расширение pear быстрее и экономичнее, чем библиотека amqplib

# EXPOSE 9000
# WORKDIR /app
# CMD [ "php-fpm", "--nodaemonize" ]
