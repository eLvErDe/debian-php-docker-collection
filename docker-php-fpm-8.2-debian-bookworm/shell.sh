#!/bin/sh

docker exec \
  --interactive \
  --tty \
  php-fpm-8.2-debian-bookworm \
  /bin/bash
