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
       wget \
       sudo \
       php-cli \
       php-fpm \
       php-mysql \
       php-pgsql \
       php-gd \
       php-mcrypt \
    && rm -rf /var/lib/apt/lists/*

# For the default PID file location
RUN mkdir /run/php

# Listen on TCP socket
RUN sed -i 's!^\(listen\s*=\s*\).*!\1127.0.0.1:9001!' /etc/php/7.0/fpm/pool.d/www.conf

# Log to host syslog (using -v /dev/log:/dev/log)
RUN sed -i 's!^;\?\(error_log\s*=\s*\).*$!\1syslog!' /etc/php/7.0/fpm/php-fpm.conf
RUN sed -i 's!^;\?\(syslog\.ident\s*=\s*\).*$!\1php-fpm-7.0-debian-stretch!' /etc/php/7.0/fpm/php-fpm.conf

# Relax error_reporting
RUN sed -i 's!^;\?\(error_reporting\s*=\s*\).*$!\1E_ALL \& ~E_DEPRECATED \& ~E_STRICT \& ~E_NOTICE!' /etc/php/7.0/fpm/php.ini

# Some env variables
RUN sed -i 's!^;\(env\[[A-Z]\+\].*\)!\1!' /etc/php/7.0/fpm/pool.d/www.conf
