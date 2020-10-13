# apidoc

Based on **node:12-alpine**

Docker hub: https://hub.docker.com/r/demidovich/apidoc

Image size: 33Mb

Requirements:

* **make**

### Make

Commands:

```
help        This help
build       Build container
clear       Remove image and containers
shell       Shell login
push        Publish image
```

### Usage

Files and directories

| File                                | Description          |
|-------------------------------------|----------------------|
| ~/myapp                             | application root     |
| ~/myapp/apidocjs.json               | apidocjs config file |
| ~/myapp/public/apidoc               | apidocjs public      |
| ~/myapp/src/Context1/Ui/Controllers | source 1             |
| ~/myapp/src/Context2/Ui/Controllers | source 2             |

docker run --rm \
    -v $(pwd)/:/home/node/apidoc demidovich/apidoc:alpine \
    -o public/apidoc \
    -i src/Context1/Ui/Controllers \
    -i src/Context2/Ui/Controllers

