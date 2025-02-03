FROM node:18.18-alpine3.17

ENV PS1='\[\033[1;36m\][\u@\h] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'
ENV PATH=/app/node_modules/.bin:$PATH
ENV UID=1000 \
    GID=1000

RUN set -x; \
    apk add --update --no-cache \
        shadow \
        git \
        bash \
        ca-certificates \
        openssl \
        openssh-client; \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config; \
    useradd node; \
    usermod -u $UID node; \
    groupmod -g $GID node; \
    chown -R $UID:$GID /home/node

COPY --chown=node:node ./conf/.gitconfig /home/node
