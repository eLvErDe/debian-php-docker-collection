#!/bin/sh

docker exec \
  --interactive \
  --tty \
  php-fpm-7.0-debian-stretch \
  /bin/bash
