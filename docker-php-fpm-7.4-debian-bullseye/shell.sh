#!/bin/sh

docker exec \
  --interactive \
  --tty \
  php-fpm-7.4-debian-bullseye \
  /bin/bash
