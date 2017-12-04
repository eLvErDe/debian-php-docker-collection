#!/bin/sh

docker build . \
  --tag php-fpm-5.3.3.1-debian-squeeze \
  $@
