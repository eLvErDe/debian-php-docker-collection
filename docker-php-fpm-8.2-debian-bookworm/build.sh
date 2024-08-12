#!/bin/sh

docker build . \
  --tag php-fpm-8.2-debian-bookworm \
  $@
