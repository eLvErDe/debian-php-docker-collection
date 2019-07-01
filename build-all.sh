#!/bin/sh

root=`dirname "${0}"`
root=`readlink -f ${root}`

for docker in "${root}/docker-php-fpm-"*; do

  container_name=`basename ${docker}`
  debian_dist=`echo ${container_name} | cut -d'-' -f6`
  docker pull debian:${debian_dist}
  cd ${docker}
  ./build.sh --no-cache
done
