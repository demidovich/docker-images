#!/bin/bash

usage() {
echo "
$(basename "$0") --url=http://localhost:8080/ --contains=\"Nginx html\"

where:
    -u --url          testing url
    -c --contains     contains content
"
}

for i in "$@"
do
case $i in
    -u=*|--url=*)
    url="${i#*=}"
    shift # past argument=value
    ;;
    -c=*|--contains=*)
    contains="${i#*=}"
    shift # past argument=value
    ;;
    *)
          # unknown option
    ;;
esac
done

if [[ ! -n $url ]]; then
    echo ""
    echo "Error: not defined \"url\" parameter"
    usage
    exit 1
fi

if [[ ! -n $contains ]]; then
    echo ""
    echo "Error: not defined \"contains\" parameter"
    usage
    exit 1
fi


if curl -s "$url" | grep "$contains" > /dev/null
then
    echo "$url: OK"
else
    echo "$url: Error"
fi
