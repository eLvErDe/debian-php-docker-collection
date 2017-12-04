FROM debian:wheezy

MAINTAINER Adam Cecile <acecile@le-vert.net>

ENV TERM xterm
ENV HOSTNAME docker-php-fpm-5.4.45-debian-wheezy.local
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
       php5-cli \
       php5-fpm \
       php5-mysql \
       php5-pgsql \
       php5-gd \
       php5-mcrypt \
    && rm -rf /var/lib/apt/lists/*

# Listen on TCP socket
RUN sed -i 's!^\(listen\s*=\s*\).*!\1127.0.0.1:9003!' /etc/php5/fpm/pool.d/www.conf

# Log to host syslog (using -v /dev/log:/dev/log)
RUN sed -i 's!^;\?\(error_log\s*=\s*\).*$!\1syslog!' /etc/php5/fpm/php-fpm.conf
RUN sed -i 's!^;\?\(syslog\.ident\s*=\s*\).*$!\1php-fpm-5.4.45-debian-wheezy!' /etc/php5/fpm/php-fpm.conf

# Relax error_reporting
RUN sed -i 's!^;\?\(error_reporting\s*=\s*\).*$!\1E_ALL \& ~E_DEPRECATED \& ~E_STRICT \& ~E_NOTICE!' /etc/php5/fpm/php.ini

# Some env variables
RUN sed -i 's!^;\(env\[[A-Z]\+\].*\)!\1!' /etc/php5/fpm/pool.d/www.conf
