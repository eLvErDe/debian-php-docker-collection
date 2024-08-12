#!/bin/sh

docker stop php-fpm-8.1-ubuntu-jammy
docker rm php-fpm-8.1-ubuntu-jammy

docker run \
  --detach \
  --tty \
  --restart=always \
  --net host \
  --volume /home/www:/home/www \
  --volume /dev/log:/dev/log \
  --mount type=tmpfs,destination=/var/lib/php/sessions,tmpfs-mode=1755,tmpfs-size=`expr 512 \* 1024 \* 1024` \
  --name php-fpm-8.1-ubuntu-jammy \
  --log-driver syslog --log-opt tag=php-fpm-8.1-ubuntu-jammy \
  php-fpm-8.1-ubuntu-jammy \
  /usr/sbin/php-fpm8.1 --nodaemonize --fpm-config /etc/php/8.1/fpm/php-fpm.conf
