# FROM composer:2.2.10 as composer
FROM spiralscout/roadrunner:2.8.8 as roadrunner

FROM php:8.1-cli-alpine3.14

# COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY --from=roadrunner /usr/bin/rr /usr/bin/rr
COPY --from=roadrunner /etc/rr.yaml /etc/rr/rr.dist.yaml

LABEL Maintainer="dm <dmitrij.demidovich@gmail.com>"

ENV PS1='\[\033[1;36m\][\u@\h] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]' \
    COMPOSER_HOME=/composer \
    TZ=${TIMEZONE:-UTC} \
    PATH=/scripts:/scripts/aliases:$PATH

ENV BUILD_DEPS \
    autoconf \
    cmake \
    dpkg-dev \
    dpkg \
    file \
    g++ \
    gcc \
    git \
    libc-dev \
    make \
    pkgconf \
    re2c

ENV RUN_DEPS \
    freetype \
    # icu-libs \
    # libintl \
    libjpeg-turbo \
    libmemcached \
    libpng \
    libxslt \
    libzip \
    postgresql-libs \
    # rabbitmq-c \
    shadow \
    zlib

ENV PHP_EXTENSIONS \
    bcmath \
    bz2 \
    exif \
    # gettext \
    gd \
    # iconv \
    # intl \
    mbstring \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    sockets \
    xsl \
    zip

ENV PECL_EXTENSIONS \
    # amqp \
    apcu \
    apfd \
    igbinary \
    memcached \
    redis \
    xdebug
    # zmq

ENV PHP_EXTENSIONS_DEPS \
    bzip2-dev \
    freetype-dev \
    # gettext-dev \
    # icu-dev \
    libevent-dev \
    libjpeg-turbo-dev \
    libmemcached-dev \
    libpng-dev  \
    libxml2-dev \
    libxslt-dev \
    oniguruma-dev \
    pcre-dev \
    postgresql-dev \
    # rabbitmq-c-dev \
    libzip-dev \
    zip

RUN set -eux; \
    apk update; \
    apk add --no-cache $RUN_DEPS; \
    apk add --no-cache $BUILD_DEPS; \
    apk add --no-cache $PHP_EXTENSIONS_DEPS; \
    ln -s /usr/lib /usr/local/lib64; \
    docker-php-ext-configure intl; \
    docker-php-ext-configure gd \
        --enable-gd \
        --with-jpeg=/usr/include/ \
        --with-freetype=/usr/include/; \
    docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd; \
    docker-php-ext-configure mysqli --with-mysqli=mysqlnd; \
    docker-php-ext-install -j$(nproc) $PHP_EXTENSIONS; \
    pecl install $PECL_EXTENSIONS; \
    docker-php-ext-enable \
        apcu \
        apfd \
        exif \
        igbinary \
        memcached \
        redis \
        zip; \
    apk del $BUILD_DEPS $PHP_EXTENSIONS_DEPS; \
    #
    # Clear
    #
    rm -rf /tmp/*; \
    rm -rf /app; \
    #
    # System sirectories
    #
    rm -rf /scripts; \
    mkdir -p \
        /app \
        /scripts/aliases \
        /etc/rr \
        /var/run/rr; \
    #
    # Info
    #
    php -v; \
    php -m;

COPY conf/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY scripts/ /scripts/

WORKDIR /app

# unset default image entrypoint
ENTRYPOINT []
