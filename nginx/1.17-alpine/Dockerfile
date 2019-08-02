FROM nginx:1.17.1-alpine

COPY \
    conf/nginx.conf \
    conf/ssl.conf \
    /etc/nginx/

VOLUME \
    /etc/nginx/hosts/ \
    /etc/nginx/certs/ \
    /app/

WORKDIR /app/

#RUN set -x ; \
#    addgroup -g 82 -S www-data ; \
#    usermod -aG www-data nginx && exit 0 ; exit 1

RUN set -x ; \
    addgroup -g 82 -S www-data ; \
    adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

EXPOSE 80

ENTRYPOINT ["nginx","-g","daemon off;"]
