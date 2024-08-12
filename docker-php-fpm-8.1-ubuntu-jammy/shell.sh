#!/bin/sh

docker exec \
  --interactive \
  --tty \
  php-fpm-8.1-ubuntu-jammy \
  /bin/bash
