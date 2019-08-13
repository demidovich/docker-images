FROM nginx:1.17.1-alpine

ENV PS1='\[\033[1;32m\]🐳  \[\033[1;36m\][\u@\h] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'

COPY \
    conf/nginx.conf \
    conf/ssl.conf \
    /etc/nginx/

RUN set -x \
    && apk add --update --no-cache shadow \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && addgroup -g 82 -S www-data ; \
    adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

EXPOSE 80

ENTRYPOINT ["nginx","-g","daemon off;"]
