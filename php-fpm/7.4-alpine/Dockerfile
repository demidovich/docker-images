FROM php:7.4.15-fpm-alpine3.13

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
    # gettext \
    gd \
    iconv \
    # intl \
    mbstring \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    sockets \
    xsl

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
    postgresql-dev
    # rabbitmq-c-dev

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
        igbinary \
        memcached \
        redis; \
    apk del $BUILD_DEPS $PHP_EXTENSIONS_DEPS; \
    #
    # Clear
    #
    rm -rf /tmp/*; \
    rm -rf /app; \
    mkdir /app; \
    rm -rf /scripts; \
    mkdir /scripts; \
    mkdir -p /scripts/aliases; \
    #
    # Info
    #
    php -v; \
    php-fpm -v; \
    php -m;

COPY conf/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY scripts/install-composer.sh /scripts/install-composer.sh
COPY scripts/scheduler.sh /scripts/scheduler.sh

WORKDIR /app
