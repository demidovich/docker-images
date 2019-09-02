FROM postgres:11.5-alpine

ARG UID=1000
ARG GID=1000
ENV UID=${UID:-1000} \
    GID=${GID:-1000}

RUN set -eux \
    && apk add --update --no-cache shadow \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && useradd -u ${UID} yazoo

USER $UID

EXPOSE 5432


