FROM alpine:3.10

LABEL Maintainer="dm <dmitrij.demidovich@gmail.com>"

# ARG BUILD_DEVELOPMENT
# ENV NODE_ENV=${BUILD_DEVELOPMENT:+development}

ENV PS1='\[\033[1;32m\]🐳  \[\033[1;36m\][\u@\h] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]' \
    PATH=/scripts:/scripts/aliases:$PATH \
    COMPOSER_VERSION=1.8.6 \
    COMPOSER_SETUP_SHA384='a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1' \
    COMPOSER_HOME=/composer \
    TZ=${TIMEZONE:-UTC} \
    USER=www-data \
    UID=82 \
    GID=82

#
# Static layer
#
RUN set -xe \
    && addgroup -g "$GID" -S "$USER" \
    && adduser  -u "$UID" -S -D -G "$USER" "$USER" \
    && apk add --update --no-cache \
        ca-certificates \
        php7 \
        php7-common \
        php7-fpm \
        php7-cli \
        php7-opcache \
        php7-openssl \
        php7-json \
        php7-iconv \
        php7-curl \
        php7-ctype \
        php7-pcntl \
        php7-posix \
        php7-phar \
        php7-mbstring \
        php7-zlib \
        php7-sodium \
        php7-pdo \
        php7-pdo_pgsql \
        php7-pdo_mysql \
        php7-redis \
        php7-bcmath \
        php7-zip \
        php7-bz2 \
        php7-fileinfo \
        php7-tokenizer \
        php7-pecl-zmq \
        php7-pecl-imagick \
        php7-pecl-xdebug

#
# Unused php extensions
#
    # AMQP

    #ln -s /usr/lib /usr/local/lib64 \
    #rabbitmq-c \
    #php7-amqp \

    # NATIVE

    #php7-mcrypt \
    #php7-pdo_sqlite \
    #php7-pdo_odbc \
    #php7-sqlite3 \
    #php7-mysqli \
    #php7-session \
    #php7-soap \
    #php7-gd \
    #php7-gettext \
    #php7-dom \
    #php7-xml \
    #php7-simplexml \

    # PECL

    #php7-pear \
    #php7-pecl-xdebug \     used
    #php7-pecl-protobuf \
    #php7-pecl-mailparse \
    #php7-pecl-imagick \    used
    #php7-pecl-amqp \
    #php7-pecl-yaml \
    #php7-pecl-redis \
    #php7-pecl-ast \
    #php7-pecl-couchbase \
    #php7-pecl-apcu \
    #php7-pecl-timezonedb \
    #php7-pecl-igbinary \
    #php7-pecl-gmagick \
    #php7-pecl-lzf \
    #php7-pecl-msgpack \
    #php7-pecl-vips \
    #php7-pecl-mcrypt \
    #php7-pecl-oauth \
    #php7-pecl-ssh2 \
    #php7-pecl-memcached \
    #tesseract-ocr \
    #php7-pecl-event \

#
# Dynamic layer
#
RUN set -xe \
    #
    # Composer
    #
    && mkdir -p "$COMPOSER_HOME" \
    && php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
    # Была какая-то проблема с хэшем на одной и той же версии
    # && php -r "if(hash_file('SHA384','/tmp/composer-setup.php')==='${COMPOSER_SETUP_SHA384}'){echo 'Verified';}else{unlink('/tmp/composer-setup.php');}" \
    && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/bin --filename=composer --version=$COMPOSER_VERSION \
    && composer --ansi --version --no-interaction \
    # && export COMPOSER_ALLOW_SUPERUSER=1 \
    && composer --no-interaction global require 'hirak/prestissimo' \
    # && export COMPOSER_ALLOW_SUPERUSER=0 \
    && composer clear-cache \
    && rm -rf /tmp/composer-setup.php \
    #
    # Clear
    #
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    #
    # Show Info
    #
    && php -v \
    && php-fpm7 -v \
    && php -m

EXPOSE 9000

CMD ["php-fpm7", "-F"]



