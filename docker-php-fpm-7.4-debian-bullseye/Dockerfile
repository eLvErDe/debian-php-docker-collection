FROM debian:bullseye

MAINTAINER Adam Cecile <acecile@le-vert.net>

ENV TERM xterm
ENV HOSTNAME docker-php-fpm-7.4-debian-bullseye.local
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
       php-enchant \
       php-curl \
       php-zip \
       php-xml \
       php-mbstring \
       imagemagick \
    && rm -rf /var/lib/apt/lists/*

# For the default PID file location
RUN mkdir /run/php

# Listen on TCP socket
RUN sed -i 's!^\(listen\s*=\s*\).*!\1127.0.0.1:9006!' /etc/php/7.4/fpm/pool.d/www.conf

# Log to host syslog (using -v /dev/log:/dev/log)
RUN sed -i 's!^;\?\(error_log\s*=\s*\).*$!\1syslog!' /etc/php/7.4/fpm/php-fpm.conf
RUN sed -i 's!^;\?\(syslog\.ident\s*=\s*\).*$!\1php-fpm-7.4-debian-bullseye!' /etc/php/7.4/fpm/php-fpm.conf

# Relax error_reporting
RUN sed -i 's!^;\?\(error_reporting\s*=\).*$!\1 E_ALL \& ~E_DEPRECATED \& ~E_STRICT \& ~E_NOTICE!' /etc/php/7.4/fpm/php.ini

# Set timezone
RUN sed -i 's!^;\?\(date.timezone\s*=\).*$!\1 Europe/Paris!' /etc/php/7.4/fpm/php.ini

# Increase memory size
RUN sed -i 's!^;\?\(memory_limit\s*=\).*$!\1 512M!' /etc/php/7.4/fpm/php.ini

# Increase post_max_size and upload_max_filesize
RUN sed -i 's!^;\?\(post_max_size\s*=\).*$!\1 16M!' /etc/php/7.4/fpm/php.ini
RUN sed -i 's!^;\?\(upload_max_filesize\s*=\).*$!\1 8M!' /etc/php/7.4/fpm/php.ini

# Increase max execution time
RUN sed -i 's!^;\?\(max_execution_time\s*=\).*$!\1 60!' /etc/php/7.4/fpm/php.ini

# Some env variables
RUN sed -i 's!^;\(env\[[A-Z]\+\].*\)!\1!' /etc/php/7.4/fpm/pool.d/www.conf

# Redirect PHP error to FPM stderr so it get displayed in docker logs
RUN sed -i -e 's!^;\?\(catch_workers_output\s*=\).*$!\1 yes!' -e 's!^;\?\(decorate_workers_output\s*=\).*$!\1 no!' /etc/php/7.4/fpm/pool.d/www.conf

# Disable PID file (needed to run as www-data user for example)
RUN sed -i 's!^;\?\(pid\s*=\)\(.*\)$!;\1 \2!' /etc/php/7.4/fpm/php-fpm.conf
