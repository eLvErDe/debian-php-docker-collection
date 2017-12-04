# From Squeeze to Stretch debian-based PHP dockers


## Why ?

PHP is a cancer every sysadmin has to live with. There's no cure and the only think we can do is try to lower the pain.

PHP API is changing so much at each minor release that when you're upgrading your Debian version you're pretty sure some PHP code will breaks.

Sometime it's trivial to fix, sometime it's not and sometime you cannot afford leaving an old rarely used page (but critical) to break at some point.

And well, most of the time, nobody will be wiling to fix it because it's either an old unmaintained code or something third-party (or third-party framework based) which is barely upgradable.


## So what can I do ?

Leave PHP in the version it was and upgrade your server anyway. People will propbably recommends using some "official" PHP containers or run everything in the container, including NGINX/Apache.

That's obviously a bad practise.

The proper way of doing this is to only interpret PHP inside the container using PHP-FPM. Everything else should stay on the host.

FPM master process should be the entrypoint of the container so docker will take care of restarting it if it breaks.

And of course, stay Debian based so you can apt-get any PHP required dependency in the container.


## Sugar provided

I personnally rebuilt latest Debian Squeeze PHP package to enable FPM backend: http://packages.le-vert.net/php5-fpm-squeeze/
I also hacked a bit to get main FMP master process to container entry point because this old version was not able to run in foreground.

All scripts provided some error proof fpm.conf/php.ini sed examples.

Everything is configured to log on host's syslog server


## Let's start

* Clone the repository and edit Dockerfile. You may change the list of installed package or add some sed to modify your fpm or base php.ini configuration.
* Run ./build.sh
* Edit run.sh to fix at least the "www" folder volume. Keep it at the same path as your host to avoid breaking everything because your skilled developpers put absolutes pathes into the code. Restrict if possible the path mounted into the container for obvious security reasons.
* Modify your apache configuration and add the following:
```
       <FilesMatch "\.php$">
            SetHandler "proxy:fcgi://127.0.0.1:9004/"
        </FilesMatch>
```
* Change the port to match your original release (or to test it with a newer one to see if it's upgradable).
  * 9004 for Debian Squeeze with PHP 5.3.3.1
  * 9003 for Debian Wheezy with PHP 5.4.45
  * 9002 for Debian Jessie with PHP 5.6.30
  * 9001 for Debian Stretch with PHP 7.0
  
## Example

```
CONTAINER ID        IMAGE                            COMMAND                  CREATED             STATUS              PORTS               NAMES
27bf611461e5        php-fpm-5.3.3.1-debian-squeeze   "/bin/sh -c '/usr/..."   About an hour ago   Up 42 minutes                           php-fpm-5.3.3.1-debian-squeeze
7adb6d39107f        php-fpm-5.4.45-debian-wheezy     "/usr/sbin/php5-fp..."   About an hour ago   Up 42 minutes                           php-fpm-5.4.45-debian-wheezy
c9edec718e48        php-fpm-5.6.30-debian-jessie     "/usr/sbin/php5-fp..."   About an hour ago   Up 42 minutes                           php-fpm-5.6.30-debian-jessie
f19b6d1cafd0        php-fpm-7.0-debian-stretch       "/usr/sbin/php-fpm..."   About an hour ago   Up 42 minutes                           php-fpm-7.0-debian-stretch
```
