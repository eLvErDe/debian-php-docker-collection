#!/bin/sh

docker stop php-fpm-5.3.3.1-debian-squeeze
docker rm php-fpm-5.3.3.1-debian-squeeze

docker run \
  --tty \
  --detach \
  --restart=always \
  --net host \
  --volume /home/www:/home/www \
  --volume /dev/log:/dev/log \
  --mount type=tmpfs,destination=/var/lib/php5,tmpfs-mode=1755,tmpfs-size=`expr 512 \* 1024 \* 1024` \
  --name php-fpm-5.3.3.1-debian-squeeze \
  --log-driver syslog --log-opt tag=php-fpm-5.3.3.1-debian-squeeze \
  --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
  php-fpm-5.3.3.1-debian-squeeze \
  /bin/sh -c '/usr/sbin/php5-fpm --fpm-config /etc/php5/fpm/php-fpm.conf && sleep 2 && reptyr -s `ps aux | grep /usr/sbin/php5-fpm | grep "^root " | grep -v grep | awk "{ print \\$2 }" | sort -n | head -n 1`'
