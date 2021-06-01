FROM demidovich/php-fpm:7.4-alpine

LABEL Maintainer="dm <dmitrij.demidovich@gmail.com>"

ARG UID=82
ARG GID=82
ARG COMPOSER_VERSION=2.0.14
ARG CHURN_VERSION="^1.0"
ARG PHPCS_VERSION="3.6.0"
ARG PSALM_VERSION="4.7.3"

ENV UID=${UID:-82} \
    GID=${GID:-82} \
    CONTAINER_ENVIRONMENT="development" \
    PATH=$PATH:/composer/vendor/bin

USER "root"

RUN set -eux; \
    if [ $UID -ne 82 ]; then \
        usermod -u ${UID} www-data; \
    fi; \
    if [ $GID -ne 82 ]; then \
        groupmod -g ${GID} www-data; \
    fi; \
    cp -f "$PHP_INI_DIR/php.ini-$CONTAINER_ENVIRONMENT" "$PHP_INI_DIR/php.ini"; \
    install-composer.sh $COMPOSER_VERSION; \
    composer global require bmitch/churn-php $CHURN_VERSION; \
    composer global require squizlabs/php_codesniffer $PHPCS_VERSION; \
    composer global require vimeo/psalm $PSALM_VERSION
    # chown -R www-data:www-data /composer
    # psalm
    # wget https://github.com/vimeo/psalm/releases/latest/download/psalm.phar -O /usr/local/bin/psalm; \
    # chmod +x /usr/local/bin/psalm;

USER "www-data"

WORKDIR /app

ENTRYPOINT []
