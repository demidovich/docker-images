FROM debian:10.9-slim

ENV PS1='\[\033[1;36m\][\u@\h] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'
ENV PATH /app/node_modules/.bin:$PATH
ENV UID=1000 \
    GID=1000

RUN set -x; \
    apt-get update; \
    apt-get -y --no-install-recommends install \
        ca-certificates \
        git \
        curl \
        npm; \
    useradd \
        --uid $UID \
        --user-group \
        --system \
        --create-home \
        node; \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config; \
    apt-get clean; \
    rm -rf \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/* \
        /usr/share/doc/*

COPY --chown=node:node ./conf/.gitconfig /home/node
