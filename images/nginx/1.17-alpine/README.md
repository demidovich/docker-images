# nginx

Based on **nginx:alpine**

Docker hub: https://hub.docker.com/r/demidovich/nginx

Image size: 21Mb

Changes:

* Added user 82:82 **www-data**
* Replace default config **/etc/nginx/nginx.conf**
* Install shadow package

Requirements:

* **make**
* **curl**

### Make

Commands:

```
help        This help
build       Build container
clear       Remove image and containers
start       Start container ($(NGINX_PORT) port)
start-host  Start container (80 port, network host)
status      Container status
stop        Stop container
shell       Shell login
push        Publish image
test        Test container
v           Show nginx version
V           Show nginx configure options
t           Test nginx configuration
T           Show nginx configuration
```

### Testing

```
# make test

nginx version: nginx/1.17.1

nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful

http://localhost:8080/: OK
```
