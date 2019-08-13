FROM alpine:3.10

LABEL Maintainer="dm <dmitrij.demidovich@gmail.com>"

ENV LC_ALL=C.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    NODE_PATH=/install/node_modules/ \
    PATH=/install/node_modules/.bin:$PATH

RUN set -xe \
    && apk add --update --no-cache \
        ca-certificates \
        autoconf \
        automake \
        libtool \
        nasm \
        build-base \
        git \
        nodejs \
        python \
        ruby \
        ruby-dev \
        nodejs-dev \
        npm \
        zlib-dev \
    && npm i npm@latest -g \
    && npm install -g \
        gulp \
        grunt \
        grunt-cli \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && node -v
    # && gulp -v \
    # && grunt -v
    # && gem install listen sass compass scss_lint --no-document

#COPY entrypoint.sh /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]

#CMD ["grunt"]
