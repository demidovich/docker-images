#!/bin/bash

usage() {
echo "
$(basename "$0") --url=http://localhost:8080/

where:
    -u --url testing url
"
}

for i in "$@"
do
case $i in
    -u=*|--url=*)
    url="${i#*=}"
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

echo ""
echo "curl -I \"$url\"" 
status=$(curl -I "$url" | grep -i "HTTP/[[:digit:]].[[:digit:]]")
echo ""

if echo $status | grep -i "200 ok" > /dev/null
then
    echo "$url: 200 OK"
else
    echo "$url: $status"
fi
