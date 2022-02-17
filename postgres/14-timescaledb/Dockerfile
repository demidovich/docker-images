FROM timescale/timescaledb:2.5.2-pg14

LABEL Maintainer="dm <dmitrij.demidovich@gmail.com>"

ENV RUN_DEPS \
    shadow \
    postgresql-contrib \
    ca-certificates

ENV BUILD_DEPS \
    postgresql-dev \
    ca-certificates \
    build-base \
    git \
    bison \
    flex

RUN set -eux; \
    apk update; \
    apk add --no-cache $RUN_DEPS; \
    apk add --no-cache $BUILD_DEPS; \
    #
    # jsquery extension
    #
    cd /tmp; \
    git clone https://github.com/postgrespro/jsquery.git; \
    cd jsquery; \
    make USE_PGXS=1; \
    make USE_PGXS=1 install; \
    apk del $BUILD_DEPS; \
    #
    # clear
    #
    rm -rf /var/cache/apk/*; \
    rm -rf /tmp/*
