# PHPfpm 8.2 Apline 3.17

Based on **php:8.2-fpm-alpine3.17**

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
* zip
* zlib

Added PHP extensions:

* bcmath
* bz2
* exif
* gd
* iconv
* mbstring
* pdo
* pdo_mysql
* pdo_pgsql
* pgsql
* sockets
* xsl
* zip

Added Pecl extensions:

* apcu
* apfd
* igbinary
* memcached
* redis

Added scripts:

* /scripts/install-composer.sh
* /scripts/scheduler.sh

### Usage

The image can be used for a web application, a queue worker, and a job scheduler.

Example of a docker-compose file for Laravel application.

```
version: "3"

services:

  app:
    image: "demidovich/php-fpm:8.2-alpine"
    container_name: "dm-fpm81-alpine-app"
    environment:
      LARAVEL_CACHE_ENABLE: 0
    volumes:
      - ./php:/app

  queue:
    image: "demidovich/php-fpm:8.2-alpine"
    container_name: "dm-fpm81-alpine-queue"
    environment:
      LARAVEL_CACHE_ENABLE: 0
    volumes:
      - ./php:/app
    command: php /app/artisan queue:work

  scheduler:
    image: "demidovich/php-fpm:8.2-alpine"
    container_name: "dm-fpm81-alpine-scheduler"
    volumes:
      - ./php:/app
    command: /scripts/scheduler.sh "php /app/artisan schedule:run --verbose --no-interaction"
```

Example of a development laravel application:

```dockerfile
FROM demidovich/php-fpm:8.2-alpine

ENV PHP_COMPOSER_VERSION=2.1.14

RUN set -eux; \
    install-composer.sh $PHP_COMPOSER_VERSION; \
    docker-php-ext-enable xdebug; \
    mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini";
```

```shell
docker run -d \
    --name myapp_container \
    -p 9000:9000 myapp_image php-fpm
```

Example of a production laravel application:

```dockerfile
FROM demidovich/php-fpm:8.2-alpine

ENV PHP_COMPOSER_VERSION=2.1.14

RUN set -eux; \
    install-composer.sh $PHP_COMPOSER_VERSION; \
    docker-php-ext-enable xdebug; \
    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini";
```

```shell
docker run -d \
    --name myapp_container \
    -p 9000:9000 myapp_image php-fpm -d opcache.enable=1
```

### Install Pecl extension

```dockerfile
FROM demidovich/php-fpm:8.2-alpine

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
FROM demidovich/php-fpm:8.2-alpine

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
