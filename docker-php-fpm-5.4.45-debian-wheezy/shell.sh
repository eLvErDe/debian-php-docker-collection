#!/bin/sh

docker exec \
  --interactive \
  --tty \
  php-fpm-5.4.45-debian-wheezy \
  /bin/bash
