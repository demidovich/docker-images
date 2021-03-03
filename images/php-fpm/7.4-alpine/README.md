# PHPfpm 7.4.15 Apline 3.13

Based on **php:7.4.15-fpm-alpine3.13**

Docker hub: https://hub.docker.com/r/demidovich/php-fpm

Image size: 108Mb

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

* apcu
* apfd
* igbinary
* memcached
* redis

### This image for laravel application

Environment variables:

* **CONTAINER_ROLE** (default app)
* **APP_CACHE_ENABLE** (default 0)
* **STDOUT** (default /proc/1/fd/1)
* **STDERR** (default /proc/1/fd/2)

The image contains script **laravel-entrypoint.sh** to start container in different modes. 
Modes are switched by the **CONTAINER_ROLE** environment variable.

* app
* queue
* scheduler

Caching is enabled by the **APP_CACHE_ENABLE** environment flag. This executes the commands:

* php artisan config:cache
* php artisan route:cache
* php artisan view:cache

Example of a Dockerfile for laravel application:

```dockerfile
FROM demidovich/php-fpm:7.4-alpine

ENV PHP_COMPOSER_VERSION=2.0.9

RUN set -eux; \
    install-composer.sh $PHP_COMPOSER_VERSION; \
    docker-php-ext-enable xdebug;

ENTRYPOINT ["laravel-entrypoint.sh"]
```

Start local application:

```shell
docker run -d \
    --name myapp_container \
    --env CONTAINER_ROLE=app \
    -p 9000:9000 myapp_image php-fpm
```

Start application in production:

```shell
docker run -d \
    --name myapp_container \
    --env CONTAINER_ROLE=app \
    --env APP_CACHE_ENABLE=1 \
    -p 9000:9000 myapp_image php-fpm -d opcache.enable=1
```

### Install Pecl extension

```dockerfile
FROM demidovich/php-fpm:7.4-alpine

RUN set -eux; \
    apk update; \
    apk add --no-cache $PHPIZE_DEPS; \
    pecl install zmq; \
    docker-php-ext-enable zmq; \
    apk del $PHPIZE_DEPS;
```

### Install extension from source

To compile, you need to intall the packages from environment variable **BUILD_DEPS**.

```dockerfile
FROM demidovich/php-fpm:7.4-alpine

ENV PHP_REDIS_VERSION=5.3.3

RUN set -eux; \
    apk update; \
    apk add --no-cache $BUILD_DEPS; \
    git clone --branch $PHP_REDIS_VERSION https://github.com/phpredis/phpredis /tmp/phpredis; \
    cd /tmp/phpredis; \
    phpize; \
    ./configure; \
    make; \
    make install; \
    make test; \
    echo 'extension=redis.so' > /usr/local/etc/php/conf.d/redis.ini; \
    apk del $BUILD_DEPS; \
    rm -rf /tmp/*;
```

### Make

Commands:

```
help        This help
build       Build image
clear       Remove image and containers
start       Start container (19000 port)
start-app   Start container with laravel entripoint (19000 port)
status      Container status
stop        Stop container
shell       Container shell
push        Publish image
info        PHP and PHPfpm info
```
