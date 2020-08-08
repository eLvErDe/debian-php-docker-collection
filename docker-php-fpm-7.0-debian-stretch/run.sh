#!/bin/sh

docker stop php-fpm-7.0-debian-stretch
docker rm php-fpm-7.0-debian-stretch

docker run \
  --detach \
  --tty \
  --restart=always \
  --net host \
  --volume /home/www:/home/www \
  --volume /dev/log:/dev/log \
  --mount type=tmpfs,destination=/var/lib/php/sessions,tmpfs-mode=1755,tmpfs-size=`expr 512 \* 1024 \* 1024` \
  --name php-fpm-7.0-debian-stretch \
  --log-driver syslog --log-opt tag=php-fpm-7.0-debian-stretch \
  php-fpm-7.0-debian-stretch \
  /usr/sbin/php-fpm7.0 --nodaemonize --fpm-config /etc/php/7.0/fpm/php-fpm.conf
