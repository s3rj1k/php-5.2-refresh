## php-debian-jessie-refresh

This repository provides legacy PHP debianized sources patched to be build on Debian 8.x "Jessie".

Resulting debian packages can be installed alongside original system PHP packages or packages from DEB.SURY.ORG repository.

### Install build requirements:

```
apt-get install build-essential devscripts git
apt-get install apache2-dev autoconf automake bison chrpath debhelper dh-apache2 dh-systemd dpkg-dev firebird-dev flex freetds-dev hardening-wrapper libapr1-dev libbz2-dev libc-client-dev libcurl4-openssl-dev libdb-dev libdjvulibre-dev libenchant-dev libevent-dev libexpat1-dev libfreetype6-dev libgcrypt11-dev libgd-dev libglib2.0-dev libgmp3-dev libicu-dev libjpeg-dev libkrb5-dev libldap2-dev libmagic-dev libmcrypt-dev libmhash-dev libmysqlclient18-dev libncurses5-dev libonig-dev libpam0g-dev libpcre3-dev libpng-dev libpq-dev libpspell-dev libqdbm-dev libreadline-dev librecode-dev libsasl2-dev libsnmp-dev libsqlite3-dev libssl-dev libsystemd-dev libtidy-dev libtiff-dev libtool libwrap0-dev libxml2-dev libxmltok1-dev libxslt1-dev locales-all mysql-server netbase netcat-traditional quilt re2c tzdata unixodbc-dev zlib1g-dev
```

### Fix for PHP-IMAP shared module:

```
cd /root
export DEB_CFLAGS_MAINT_APPEND=-fPIC
apt-get -y build-dep uw-imap && apt-get -y --build source uw-imap
dpkg -i libc-client*.deb mlock*.deb
```

### Clone all branch to your build server:

```
cd /root
git clone https://github.com/s3rj1k/php-debian-jessie-refresh.git

cp -a /root/php-debian-jessie-refresh /root/php_5.2_build
cp -a /root/php-debian-jessie-refresh /root/php_5.3_build
cp -a /root/php-debian-jessie-refresh /root/php_5.4_build

cd /root/php_5.2_build
git checkout PHP-5.2

cd /root/php_5.3_build
git checkout PHP-5.3.29

cd /root/php_5.4_build
git checkout PHP-5.4.45
```

### Build all PHP versions with enabled tests:

```
cd /root/php_5.2_build
debuild -us -uc -b

cd /root/php_5.3_build
debuild -us -uc -b

cd /root/php_5.4_build
debuild -us -uc -b
```
