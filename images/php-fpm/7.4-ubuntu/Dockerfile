# BASE IMAGE
# ----------------------------------------------
# Fork from phpdockerio/php74-fpm

FROM ubuntu:bionic AS base

LABEL Maintainer="dm <dmitrij.demidovich@gmail.com>"

ENV PS1='\[\033[1;32m\]🐳  \[\033[1;36m\][\u@\h] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]' \
    PATH=/scripts:/scripts/aliases:$PATH \
    COMPOSER_VERSION=1.10.1 \
    COMPOSER_HOME=/composer \
    TZ=${TIMEZONE:-UTC}

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends gnupg \
    && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main" > /etc/apt/sources.list.d/ondrej-php.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
    && apt-get update \
    && apt-get -y --no-install-recommends install \
        ca-certificates \
        curl \
        unzip \
        make \
        php7.4-fpm \
        php-apcu \
        php-apcu-bc \
        php7.4-cli \
        php7.4-curl \
        php7.4-json \
        php7.4-mbstring \
        php7.4-opcache \
        php7.4-readline \
        php7.4-xml \
        php7.4-zip \
        php7.4-gd \
        php7.4-bcmath \
        php7.4-pgsql \
        php7.4-mysql \
        php-redis \
        php-xdebug \
    && mkdir -p "$COMPOSER_HOME" \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=$COMPOSER_VERSION \
    && composer global require hirak/prestissimo \
    && composer clear-cache \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* ~/.composer \
    && php -v \
    && php-fpm7.4 -v \
    && php -m

STOPSIGNAL SIGQUIT

COPY overrides.conf /etc/php/7.4/fpm/pool.d/z-overrides.conf

CMD ["/usr/sbin/php-fpm7.4", "-O" ]

EXPOSE 9000

# BUILD EXTENSIONS
# ----------------------------------------------

FROM base AS builder

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends php7.4-dev git \
    && cd /root \
    && git clone https://github.com/m6w6/ext-apfd \
    && cd ext-apfd \
    && phpize \
    && ./configure \
    && make

# FINAL IMAGE
# ----------------------------------------------
# install builded extensions
# disable extensions

FROM base AS release

COPY --from=builder /root/ext-apfd/ /root/ext-apfd/

RUN set -x \
    # APFD
    && cd /root/ext-apfd/ \
    && chmod -x ./modules/apfd.so \
    #&& cp /root/ext-apfd/modules/apfd.so /usr/lib/php/20190902/apfd.so \
    && make install \
    && echo "extension=apfd.so" > /etc/php/7.4/mods-available/apfd.ini \
    && phpenmod -v 7.4 apfd \
    # TIDEWAYS XHPROF
    && curl -L https://github.com/tideways/php-xhprof-extension/releases/download/v5.0.2/tideways-xhprof_5.0.2_amd64.deb -o /tmp/xhprof.deb \
    && dpkg -i /tmp/xhprof.deb \
    && rm /tmp/xhprof.deb \
    && echo "extension=/usr/lib/tideways_xhprof/tideways_xhprof-7.4.so" > /etc/php/7.4/mods-available/tideways_xhprof.ini \
    && phpenmod -v 7.4 tideways_xhprof \
    # MODULES
    && phpdismod -v 7.4 xdebug



