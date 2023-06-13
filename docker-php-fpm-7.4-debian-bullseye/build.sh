#!/bin/sh

docker build . \
  --tag php-fpm-7.4-debian-bullseye \
  $@
