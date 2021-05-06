FROM alpine:3.13

ENV PS1='\[\033[1;36m\][\u@\h] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'
ENV PATH /app/node_modules/.bin:$PATH

RUN set -xe; \
    apk update; \
    apk add --no-cache \
        shadow \
        git \
        bash \
        ca-certificates \
        openssl \
        openssh-client \
        mc; \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config; \
    addgroup node; \
    adduser -h /home/node -G node -D node

RUN set -xe; \
    apk add --no-cache --virtual .build-deps \
        curl \
        ncurses \ 
        coreutils \ 
        python2 \
        make \
        gcc \
        g++ \
        libgcc \
        linux-headers \ 
        findutils \
        grep \
        util-linux \ 
        binutils

USER node
RUN set -x; \
    touch ~/.bashrc; \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | /bin/bash; \
    source ~/.bashrc
COPY ./conf/.gitconfig /home/node

USER root
RUN apk del .build-deps; \
    rm -rf /var/cache/apk/* \
    rm -rf /tmp/*

USER node
