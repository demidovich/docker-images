#!/usr/bin/env sh
set -e

usage()
{
   echo ""
   echo "Usage: $0 1.9.0"
   exit 1
}

while getopts "h:" opt
do
   case "$opt" in
      h ) usage ;;
   esac
done

if [ -z "$1" ]
then
   version_option=""
else
   version_option="--version=$1"
fi

php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
&& php /tmp/composer-setup.php \
    --no-ansi \
    --install-dir=/usr/local/bin \
    --filename=composer \
    $version_option \
&& composer --ansi --version --no-interaction \
&& composer clear-cache

rm -rf /tmp/composer-setup.php
