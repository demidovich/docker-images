#!/usr/bin/env sh
set -e

CONTAINER_ROLE="${CONTAINER_ROLE:-app}"
CONTAINER_STDOUT="${CONTAINER_STDOUT:-/proc/1/fd/1}";
CONTAINER_STDERR="${CONTAINER_STDERR:-/proc/1/fd/2}";
LARAVEL_CACHE_ENABLE="${LARAVEL_CACHE_ENABLE:-0}"

if [ "$LARAVEL_CACHE_ENABLE" = "'On" ]; then
    LARAVEL_CACHE_ENABLE="1"
fi

if [ "$LARAVEL_CACHE_ENABLE" = "on" ]; then
    LARAVEL_CACHE_ENABLE="1"
fi

if [ "$LARAVEL_CACHE_ENABLE" = "1" ]; then
    echo "Caching configuration..."
    (php "$@" artisan config:cache && php "$@" artisan route:cache && php "$@" artisan view:cache)
else
    echo "Clear configuration caching..."
    (php "$@" artisan config:clear && php "$@" artisan route:clear && php "$@" artisan view:clear && php "$@" artisan cache:clear)
fi

if [ "$CONTAINER_ROLE" = "app" ]; then
    exec "$@"

elif [ "$CONTAINER_ROLE" = "queue" ]; then
    echo "Running the queue..."
    php "$@" artisan queue:work --verbose --tries=3 --timeout=90 > ${CONTAINER_STDOUT} 2> ${CONTAINER_STDERR}

elif [ "$CONTAINER_ROLE" = "scheduler" ]; then
    echo "START SCHEDULER CONTAINER ROLE"
    echo "[ Info ] Delay between executions: 60"
    echo "[ Info ] Press [CTRL+C] to stop"
    trap "echo SIGHUP" HUP
    trap "echo Shutting down; exit" TERM
    sleep 2
    while [ true ]
    do
        php "$@" artisan schedule:run --verbose --no-interaction > ${CONTAINER_STDOUT} 2> ${CONTAINER_STDERR} &
        sleep 60
    done

else 
    echo "Could not match the container role \"$role\""
    exit 1
fi
