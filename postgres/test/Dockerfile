FROM postgres:11-alpine
MAINTAINER="dm <dmitrij.demidovich@gmail.com>"

ENV LANG=ru_RU.utf8 \
    PGDATA=/var/lib/pgsql/data/ \
    POSTGRES_DB=postgres \
    POSTGRES_USER=postgres \
    POSTGRES_PASSWORD=postgres

COPY init.sql/*.sql /init.sql/

RUN echo '1) Install packages' \
        && apk add --no-cache su-exec \
    && echo '2) Start Postgres DB' \
        && bash -c '/docker-entrypoint.sh postgres --autovacuum=off &' \
        && sleep 10 \
    && echo '3) Populate DB' \
        && psql -U $POSTGRES_USER $POSTGRES_DB < /init.sql/01_dump.sql \
        && psql -U $POSTGRES_USER $POSTGRES_DB < /init.sql/02_cleaner.sql \
    && echo '4) Stop Postgresql DB' \
        && exec su-exec postgres pg_ctl -D "$PGDATA" -m fast -w stop \
        && sleep 10 \
    && echo '5) Delete init SQL' \
        && rm -f /init.sql/* \
    && echo '6) Clear APK' \
        && rm -rf /var/cache/apk/* \
        && rm -rf /tmp/*

#RUN echo '6) Clean Postgres log' \
#    && exec su-exec postgres pg_resetxlog -o $( LANG=C pg_controldata $PGDATA | grep -oP '(?<=NextOID:\s{10})\d+' ) -x $( LANG=C pg_controldata $PGDATA | grep -oP '(?<=NextXID:\s{10}0[/:])\d+' ) -f $PGDATA \

#RUN ln -sb /bin/bash /bin/sh

EXPOSE 5432
