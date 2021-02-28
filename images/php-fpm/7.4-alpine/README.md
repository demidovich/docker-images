# PHPfpm 7.4.15 Apline 3.13

Based on **php:7.4.15-fpm-alpine3.13**

Docker hub: https://hub.docker.com/r/demidovich/php-fpm

Image size: 107Mb

Added packages:

* freetype
* libjpeg-turbo
* libmemcached
* libpng
* libxslt
* libzip
* postgresql-libs
* shadow
* zlib

Added PHP extensions:

* bcmath
* bz2
* gd
* iconv
* mbstring
* pdo
* pdo_mysql
* pdo_pgsql
* pgsql
* sockets
* xsl

Added Pecl extensions:

* apfd
* igbinary
* memcached
* redis

### Example for local development

```dockerfile
FROM demidovich/php-fpm:7.4-alpine

PHP_COMPOSER_VERSION=2.0.9

RUN set -xe \
    && install-composer $PHP_COMPOSER_VERSION
    && docker-php-ext-enable xdebug
```

### Install composer

```dockerfile
FROM demidovich/php-fpm:7.4-alpine

PHP_COMPOSER_VERSION=2.0.9

RUN install-composer $PHP_COMPOSER_VERSION
```

### Enable Xdebug

The xdebug extension is installed but disabled. 

```dockerfile
FROM demidovich/php-fpm:7.4-alpine

RUN set -xe \
    && docker-php-ext-enable xdebug
```

### Install Pecl extension

```dockerfile
FROM demidovich/php-fpm:7.4-alpine

RUN set -xe \
    && apk update \
    && apk add --no-cache $PHPIZE_DEPS \
    && pecl install zmq \
    && docker-php-ext-enable zmq
    && apk del $PHPIZE_DEPS
```

### Install extension from source

To compile, you need to intall the packages from environment variable $BUILD_DEPS.

```dockerfile
FROM demidovich/php-fpm:7.4-alpine

PHP_REDIS_VERSION=5.3.3

RUN set -xe \
    && apk update \
    && apk add --no-cache $BUILD_DEPS \
    && git clone --branch $PHP_REDIS_VERSION https://github.com/phpredis/phpredis /tmp/phpredis \
    && cd /tmp/phpredis \
    && phpize  \
    && ./configure  \
    && make  \
    && make install \
    && make test \
    && echo 'extension=redis.so' > /usr/local/etc/php/conf.d/redis.ini \
    && apk del $BUILD_DEPS \
    && rm -rf /tmp/*
```

### Make

Commands:

```
help        This help
build       Build image
clear       Remove image and containers
start       Start container (19000 port)
start-host  Start container (9000 port, network host)
status      Container status
stop        Stop container
shell       Container shell
push        Publish image
info        PHP and PHPfpm info
```
