FROM postgres:15.2

LABEL Maintainer="dm <dmitrij.demidovich@gmail.com>"

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
         ca-certificates \
         wget \
         postgresql-15-rum \
          postgresql-15-postgis-3 \
          postgresql-15-postgis-3-scripts \
          postgresql-15-jsquery \
          pg-activity \
    && rm -rf /var/lib/apt/lists/*

# RUN set -eux \
#     && wget -O /usr/share/postgresql/12/extension/jsquery--1.1.sql "https://raw.githubusercontent.com/postgrespro/jsquery/master/jsquery--1.1.sql" \
#     && wget -O /usr/share/postgresql/12/extension/jsquery.control "https://raw.githubusercontent.com/postgrespro/jsquery/master/jsquery.control" \
#     && wget -O /usr/share/postgresql/12/extension/hunspell_ru_ru--1.0.sql "https://github.com/postgrespro/hunspell_dicts/raw/master/hunspell_ru_ru/hunspell_ru_ru--1.0.sql" \
#     && wget -O /usr/share/postgresql/12/extension/hunspell_ru_ru.control "https://github.com/postgrespro/hunspell_dicts/raw/master/hunspell_ru_ru/hunspell_ru_ru.control" \
#     && wget -O /usr/share/postgresql/12/tsearch_data/ru_ru.dict "https://github.com/postgrespro/hunspell_dicts/raw/master/hunspell_ru_ru/ru_ru.dict" \
#     && wget -O /usr/share/postgresql/12/tsearch_data/ru_ru.affix "https://github.com/postgrespro/hunspell_dicts/raw/master/hunspell_ru_ru/ru_ru.affix"
