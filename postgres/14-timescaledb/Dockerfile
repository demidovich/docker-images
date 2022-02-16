FROM timescale/timescaledb:2.5.2-pg14

LABEL Maintainer="dm <dmitrij.demidovich@gmail.com>"

RUN set -eux \
    && apk add --update --no-cache shadow \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*
