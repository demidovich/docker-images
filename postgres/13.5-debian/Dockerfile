FROM postgres:13.5

LABEL Maintainer="dm <dmitrij.demidovich@gmail.com>"

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
         ca-certificates \
         wget \
         postgresql-13-rum \
         postgresql-13-postgis-3 \
         postgresql-13-postgis-3-scripts \
         postgresql-13-jsquery \
         pg-activity \
    && rm -rf /var/lib/apt/lists/*
