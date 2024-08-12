#!/bin/sh

docker build . \
  --tag php-fpm-8.1-ubuntu-jammy \
  $@
