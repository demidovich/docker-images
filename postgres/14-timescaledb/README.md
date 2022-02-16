# Timescaledb 2.5.2 Postgresql 14.2 alpine

Based on **timescale/timescaledb:2.5.2-pg14**

Docker hub: https://hub.docker.com/r/demidovich/postgres

Image size: 261Mb

Changes:

* Add **shadow** package

```
help            This help
build           Build container
clear           Remove image and containers
start           Start container (15432 port)
status          Container status
stop            Stop container
shell           Shell login
push            Publish image
test            Test image
v               Show Postgresql version
```

Extensions:

* btree_gist
* pg_stat_statements
* pg_trgm
* timescaledb
* uuid-ossp
