#!/usr/bin/env sh

trap "echo SIGHUP" HUP
trap "echo Shutting down; exit" TERM

while :; do
  sleep 60;
done;
