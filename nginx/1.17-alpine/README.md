# nginx

Based on **nginx:alpine**

Changes:

* User replace to **www-data**
* Replace default config **/etc/nginx/nginx.conf**
* Add volumes: **/etc/nginx/hosts**, **/app**

Requirements:

* **make**
* **curl**

### Make

Commands:

```
help            This help
build           Build container
clear           Remove image and containers
start           Start container (8080 port)
start-host      Start container (80 port, network host)
status          Container status
stop            Stop container
shell           Shell login
test            Test container
v               Show nginx version
V               Show nginx configure options
t               Test nginx configuration
T               Show nginx configuration
```

### Testing

```
# make test

nginx version: nginx/1.17.1

nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful

http://localhost:8080/: OK
```
