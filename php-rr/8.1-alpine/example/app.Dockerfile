FROM composer:2.2.10 as composer

FROM demidovich/php-rr:8.1-alpine

COPY --from=composer /usr/bin/composer /usr/bin/composer

ARG HOST_UID=82
ARG HOST_GID=82

ENV HOST_UID=${HOST_UID:-82} \
    HOST_GID=${HOST_GID:-82} \
    CONTAINER_ENVIRONMENT=${CONTAINER_ENVIRONMENT:-production}

COPY ./zz-options.ini /usr/local/etc/php/conf.d/

RUN set -eux; \
    if [ $HOST_UID -ne 82 ]; then \
        usermod -u ${HOST_UID} www-data; \
    fi; \
    # macos fix
    # if [ $HOST_GID -ne 82 ]; then \
    if [ $HOST_GID -ne 82 ] && ! grep -q :${HOST_GID}: /etc/group; then \
        groupmod -g ${HOST_GID} www-data; \
    fi; \
    if [ "$CONTAINER_ENVIRONMENT" != "production" ]; then \
        CONTAINER_ENVIRONMENT="development"; \
    fi; \
    cp -f "$PHP_INI_DIR/php.ini-$CONTAINER_ENVIRONMENT" "$PHP_INI_DIR/php.ini"; \
    #
    # roadrunner
    #
    chown -R www-data:www-data /var/run/rr

USER "www-data"

WORKDIR /app
