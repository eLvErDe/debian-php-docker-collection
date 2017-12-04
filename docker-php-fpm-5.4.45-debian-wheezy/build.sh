#!/bin/sh

docker build . \
  --tag php-fpm-5.4.45-debian-wheezy \
  $@
