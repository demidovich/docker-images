FROM demidovich/nginx:1.17-alpine

ARG UID=82
ARG GID=82
ENV UID=${UID:-82} \
    GID=${GID:-82}

COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/nginx/host.conf /etc/nginx/hosts/host.conf

RUN set -eux \
    # && sed -i "s#%USER_ID%#${UID}#g" "/etc/php7/php-fpm.d/www.conf" \
    # && sed -i "s#%GROUP_ID%#${GID}#g" "/etc/php7/php-fpm.d/www.conf"
    && if [ $UID -ne 82 ]; then \
        usermod -u $UID www-data; \
    fi \
    && if [ $GID -ne 82 ]; then \
        groupmod -g $GID www-data; \
    fi \
    # && chown -R ${UID}:${GID} /var/run/nginx.pid \
    # && chown -R ${UID}:${GID} /var/cache/nginx \
    && touch /run/nginx.pid \
    && chown \
        --changes \
        --silent \
        --no-dereference \
        --recursive \
        ${UID}:${GID} \
        /run/nginx.pid \
        /var/cache/nginx

# USER $UID

WORKDIR /app

EXPOSE 8080


