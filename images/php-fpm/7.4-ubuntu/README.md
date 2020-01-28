# PHP-FPM 7.4.2

Based on **ubuntu:bionic**

Fork from **phpdockerio/php74-fpm**

Image size: 175Mb

Installed:

* **composer**
* **hirak/prestissimo** composer package
* **PHP extensions**: pgsql, mysql, redis, apcu, opcache, xdebug 

Installed PHP modules:

* apc
* apcu
* bcmath
* calendar
* Core
* ctype
* curl
* date
* dom
* exif
* FFI
* fileinfo
* filter
* ftp
* gd
* gettext
* hash
* iconv
* igbinary
* json
* libxml
* mbstring
* mysqli
* mysqlnd
* openssl
* pcntl
* pcre
* PDO
* pdo_mysql
* pdo_pgsql
* pgsql
* Phar
* posix
* readline
* redis
* Reflection
* session
* shmop
* SimpleXML
* sockets
* sodium
* SPL
* standard
* sysvmsg
* sysvsem
* sysvshm
* tokenizer
* xdebug
* xml
* xmlreader
* xmlwriter
* xsl
* Zend OPcache
* zip
* zlib

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
test            Test image
v               Show PHP-FPM version
m               Show PHP-FPM installed modules
t               Test PHP-FPM config
```

### Testing

```
# make start
# make test
# make stop
```

