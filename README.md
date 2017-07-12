## php-debian-jessie-refresh

This branch provides additional extensions for legacy PHP versions.

### Install build requirements:

```
apt-get install build-essential devscripts git
apt-get install libgeoip-dev libmagickcore-dev libmagickwand-dev libmemcached-dev libpcre3-dev zlib1g-dev
apt-get install php5.2-dev php5.3-dev php5.4-dev php5.2-cli php5.3-cli php5.4-cli
```

### Clone this branch to your build server:

```
cd /root
git clone https://github.com/s3rj1k/php-debian-jessie-refresh.git

mv /root/php-debian-jessie-refresh /root/php_ext

cd /root/php_ext
git checkout PHP-EXT
```

### Build all extensions for all legacy PHP's:

```
cd /root/php_ext/php5.2-apc
debuild -us -uc -b

cd /root/php_ext/php5.2-geoip
debuild -us -uc -b

cd /root/php_ext/php5.2-imagick
debuild -us -uc -b

cd /root/php_ext/php5.2-memcache
debuild -us -uc -b

cd /root/php_ext/php5.2-memcached
debuild -us -uc -b

cd /root/php_ext/php5.2-opcache
debuild -us -uc -b

cd /root/php_ext/php5.2-timezonedb
debuild -us -uc -b

cd /root/php_ext/php5.2-xcache
debuild -us -uc -b

cd /root/php_ext/php5.2-xdebug
debuild -us -uc -b

cd /root/php_ext/php5.3-apc
debuild -us -uc -b

cd /root/php_ext/php5.3-geoip
debuild -us -uc -b

cd /root/php_ext/php5.3-imagick
debuild -us -uc -b

cd /root/php_ext/php5.3-memcache
debuild -us -uc -b

cd /root/php_ext/php5.3-memcached
debuild -us -uc -b

cd /root/php_ext/php5.3-opcache
debuild -us -uc -b

cd /root/php_ext/php5.3-timezonedb
debuild -us -uc -b

cd /root/php_ext/php5.3-xcache
debuild -us -uc -b

cd /root/php_ext/php5.3-xdebug
debuild -us -uc -b

cd /root/php_ext/php5.4-apc
debuild -us -uc -b

cd /root/php_ext/php5.4-geoip
debuild -us -uc -b

cd /root/php_ext/php5.4-imagick
debuild -us -uc -b

cd /root/php_ext/php5.4-memcache
debuild -us -uc -b

cd /root/php_ext/php5.4-memcached
debuild -us -uc -b

cd /root/php_ext/php5.4-opcache
debuild -us -uc -b

cd /root/php_ext/php5.4-timezonedb
debuild -us -uc -b

cd /root/php_ext/php5.4-xcache
debuild -us -uc -b

cd /root/php_ext/php5.4-xdebug
debuild -us -uc -b
```