FROM postgres:11.5-alpine

LABEL Maintainer="dm <dmitrij.demidovich@gmail.com>"

RUN set -eux \
    && apk add --update --no-cache shadow \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*



