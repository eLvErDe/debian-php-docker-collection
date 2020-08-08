#!/bin/sh

docker stop php-fpm-5.6.30-debian-jessie
docker rm php-fpm-5.6.30-debian-jessie

docker run \
  --detach \
  --tty \
  --restart=always \
  --net host \
  --volume /home/www:/home/www \
  --volume /dev/log:/dev/log \
  --mount type=tmpfs,destination=/var/lib/php5/sessions,tmpfs-mode=1755,tmpfs-size=`expr 512 \* 1024 \* 1024` \
  --name php-fpm-5.6.30-debian-jessie \
  --log-driver syslog --log-opt tag=php-fpm-5.6.30-debian-jessie \
  php-fpm-5.6.30-debian-jessie \
  /usr/sbin/php5-fpm --nodaemonize --fpm-config /etc/php5/fpm/php-fpm.conf
