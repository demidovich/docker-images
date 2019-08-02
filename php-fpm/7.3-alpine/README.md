# PHP-FPM 7.3

Based on **alpine:3.10**

Docker hub: [https://hub.docker.com/r/demidovich/php-fpm]
Image size: 51Mb

Changes:

* Add user and group **www-data**
* Install **composer**
* Install **hirak/prestissimo** composer package

Installed PHP modules:

* php7-fpm 
* php7-cli 
* php7-opcache 
* php7-openssl 
* php7-json 
* php7-iconv 
* php7-curl 
* php7-ctype 
* php7-pcntl 
* php7-posix 
* php7-phar 
* php7-mbstring 
* php7-zlib 
* php7-sodium 
* php7-pdo 
* php7-pdo_pgsql 
* php7-pdo_mysql 
* php7-redis 
* php7-bcmath 
* php7-zip 
* php7-bz2 
* php7-fileinfo 
* php7-tokenizer 
* php7-pecl-zmq 
* php7-pecl-imagick 
* php7-pecl-xdebug

### Make

Commands:

```
help            This help
build           Build container
clear           Remove image and containers
start           Start container (19000 port)
start-host      Start container (9000 port, network host)
status          Container status
stop            Stop container
shell           Shell login
push            Publish image
v               Show PHP-FPM version
m               Show PHP-FPM installed modules
t               Test PHP-FPM config
```

### Testing

```
# make start
# make test

PHP 7.3.7 (fpm-fcgi) (built: Jul  8 2019 09:58:12)
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.3.7, Copyright (c) 1998-2018 Zend Technologies
    with Zend OPcache v7.3.7, Copyright (c) 1999-2018, by Zend Technologies

[02-Aug-2019 15:41:19] NOTICE: configuration file /etc/php7/php-fpm.conf test is successful

PHP CLI: OK

```