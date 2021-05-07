#!/bin/bash

docker run --rm \
    -v $(pwd)/myapp/:/home/node/apidoc demidovich/apidoc:alpine \
    -o public/apidoc \
    -i src/Context1/Ui/Controllers \
    -i src/Context2/Ui/Controllers

