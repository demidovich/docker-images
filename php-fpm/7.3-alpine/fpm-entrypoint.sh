#!/usr/bin/env sh
set -e

CONFIG_PATH="/etc/php7/php-fpm.conf";
USER_ID="${USER_ID:-1000}";
GROUP_ID="${GROUP_ID:-1000}";
FPM_PORT="${FPM_PORT:-9000}";

echo "fpm-entirypoint.sh"
echo "init $CONFIG_PATH"

sed -i "s#%USER_ID%#${USER_ID}#g" "$CONFIG_PATH";
sed -i "s#%GROUP_ID%#${GROUP_ID}#g" "$CONFIG_PATH";
sed -i "s#%FPM_PORT%#${FPM_PORT}#g" "$CONFIG_PATH";

echo "set   USER_ID  $USER_ID"
echo "set   GROUP_ID $GROUP_ID"
echo "set   FPM_PORT $FPM_PORT"

ln /usr/sbin/php-fpm7 /usr/sbin/php-fpm

echo "link /usr/sbin/php-fpm7 -> /usr/sbin/php-fpm"

exec "$@";
