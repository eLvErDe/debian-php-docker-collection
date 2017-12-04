#!/bin/sh

docker build . \
  --tag php-fpm-7.0-debian-stretch \
  $@
