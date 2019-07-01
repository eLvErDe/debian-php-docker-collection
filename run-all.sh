#!/bin/sh

root=`dirname "${0}"`
root=`readlink -f ${root}`

for docker in "${root}/docker-php-fpm-"*; do
  container_name=`basename ${docker}`
  cd ${docker}
  ./run.sh
done
