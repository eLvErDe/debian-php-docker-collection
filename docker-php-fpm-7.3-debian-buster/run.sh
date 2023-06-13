#!/bin/sh

docker stop php-fpm-7.3-debian-buster
docker rm php-fpm-7.3-debian-buster

docker run \
  --detach \
  --tty \
  --restart=always \
  --net host \
  --volume /home/www:/home/www \
  --volume /dev/log:/dev/log \
  --mount type=tmpfs,destination=/var/lib/php/sessions,tmpfs-mode=1755,tmpfs-size=`expr 512 \* 1024 \* 1024` \
  --name php-fpm-7.3-debian-buster \
  --log-driver syslog --log-opt tag=php-fpm-7.3-debian-buster \
  php-fpm-7.3-debian-buster \
  /usr/sbin/php-fpm7.3 --nodaemonize --fpm-config /etc/php/7.3/fpm/php-fpm.conf
