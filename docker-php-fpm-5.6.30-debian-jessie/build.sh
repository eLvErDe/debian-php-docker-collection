#!/bin/sh

docker build . \
  --tag php-fpm-5.6.30-debian-jessie \
  $@
