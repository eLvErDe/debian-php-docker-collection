FROM debian:stretch

MAINTAINER Adam Cecile <acecile@le-vert.net>

ENV TERM xterm
ENV HOSTNAME docker-php-fpm-7.0-debian-stretch.local
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root

# Upgrade base system
RUN apt-get update \
    && apt-get -y -o 'Dpkg::Options::=--force-confdef' -o 'Dpkg::Options::=--force-confold' --no-install-recommends dist-upgrade \
    && rm -rf /var/lib/apt/lists/*

# Display FQDN hostname in prompt
RUN sed -i 's!h:!H:!g' /etc/bash.bashrc

# Install php-fpm and dependencies
RUN apt-get update \
    && apt-get -y -o 'Dpkg::Options::=--force-confdef' -o 'Dpkg::Options::=--force-confold' --no-install-recommends install \
       sendmail \
       wget ca-certificates \
       sudo \
       php-cli \
       php-fpm \
       php-mysql \
       php-pgsql \
       php-gd \
       php-mcrypt \
       imagemagick \
    && rm -rf /var/lib/apt/lists/*

# For the default PID file location
RUN mkdir /run/php

# Listen on TCP socket
RUN sed -i 's!^\(listen\s*=\s*\).*!\1127.0.0.1:9001!' /etc/php/7.0/fpm/pool.d/www.conf

# Log to host syslog (using -v /dev/log:/dev/log)
RUN sed -i 's!^;\?\(error_log\s*=\s*\).*$!\1syslog!' /etc/php/7.0/fpm/php-fpm.conf
RUN sed -i 's!^;\?\(syslog\.ident\s*=\s*\).*$!\1php-fpm-7.0-debian-stretch!' /etc/php/7.0/fpm/php-fpm.conf

# Relax error_reporting
RUN sed -i 's!^;\?\(error_reporting\s*=\).*$!\1 E_ALL \& ~E_DEPRECATED \& ~E_STRICT \& ~E_NOTICE!' /etc/php/7.0/fpm/php.ini

# Set timezone
RUN sed -i 's!^;\?\(date.timezone\s*=\).*$!\1 Europe/Paris!' /etc/php/7.0/fpm/php.ini

#  Increase memory size
RUN sed -i 's!^;\?\(memory_limit\s*=\).*$!\1 512M!' /etc/php/7.0/fpm/php.ini

#  Increase post_max_size and upload_max_filesize
RUN sed -i 's!^;\?\(post_max_size\s*=\).*$!\1 16M!' /etc/php/7.0/fpm/php.ini
RUN sed -i 's!^;\?\(upload_max_filesize\s*=\).*$!\1 8M!' /etc/php/7.0/fpm/php.ini

# Some env variables
RUN sed -i 's!^;\(env\[[A-Z]\+\].*\)!\1!' /etc/php/7.0/fpm/pool.d/www.conf
