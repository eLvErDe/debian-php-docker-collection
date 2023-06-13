#!/bin/sh

docker build . \
  --tag php-fpm-7.3-debian-buster \
  $@
