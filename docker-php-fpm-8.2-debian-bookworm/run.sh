#!/bin/sh

docker stop php-fpm-8.2-debian-bookworm
docker rm php-fpm-8.2-debian-bookworm

docker run \
  --detach \
  --tty \
  --restart=always \
  --net host \
  --volume /home/www:/home/www \
  --volume /dev/log:/dev/log \
  --mount type=tmpfs,destination=/var/lib/php/sessions,tmpfs-mode=1755,tmpfs-size=`expr 512 \* 1024 \* 1024` \
  --name php-fpm-8.2-debian-bookworm \
  --log-driver syslog --log-opt tag=php-fpm-8.2-debian-bookworm \
  php-fpm-8.2-debian-bookworm \
  /usr/sbin/php-fpm8.2 --nodaemonize --fpm-config /etc/php/8.2/fpm/php-fpm.conf
