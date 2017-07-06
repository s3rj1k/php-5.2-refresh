## php-debian-jessie-refresh, branch PHP-5.2

This repository branch provides PHP-5.2.17 debianized sources patched to be build on Debian 8.x "Jessie".

Resulting debian packages can be installed alongside original system PHP packages or packages from DEB.SURY.ORG repository.

### Install build requirements:

```
apt-get install build-essential devscripts git
apt-get install apache2-dev dh-apache2 dh-systemd libsystemd-dev autoconf automake bison chrpath debhelper dpkg-dev firebird-dev flex freetds-dev libapr1-dev libbz2-dev libc-client-dev libcurl4-openssl-dev libdb-dev libdjvulibre-dev libexpat1-dev libfreetype6-dev libgcrypt11-dev libgd-dev libgmp3-dev libjpeg-dev libkrb5-dev libldap2-dev libmcrypt-dev libmhash-dev libmysqlclient18-dev libncurses5-dev libpam0g-dev libpcre3-dev libpng-dev libpspell-dev libreadline-dev librecode-dev libsasl2-dev libsqlite3-dev libssl-dev libtidy-dev libtiff-dev libtool libwrap0-dev libxmltok1-dev libxml2-dev libxslt1-dev re2c unixodbc-dev zlib1g-dev tzdata mysql-server
```

### Fix for PHP-IMAP shared module:

```
cd /root
export DEB_CFLAGS_MAINT_APPEND=-fPIC
apt-get -y build-dep uw-imap && apt-get -y --build source uw-imap
dpkg -i libc-client*.deb mlock*.deb
```

### Clone this branch to your build server:

```
cd /root
git clone https://github.com/s3rj1k/php-debian-jessie-refresh.git
cd /root/php-debian-jessie-refresh
git checkout PHP-5.2
```

### Build PHP with enabled tests:

```
debuild -us -uc -b
```

### Build PHP with disabled tests:

```
DEB_BUILD_OPTIONS=nocheck debuild -us -uc -b
```
