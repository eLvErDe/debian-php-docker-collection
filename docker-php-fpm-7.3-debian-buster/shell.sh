#!/bin/sh

docker exec \
  --interactive \
  --tty \
  php-fpm-7.3-debian-buster \
  /bin/bash
