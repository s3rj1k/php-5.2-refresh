## php-debian-jessie-refresh, branch PHP-5.4

This repository branch provides PHP-5.4.45 debianized sources patched to be build on Debian 8.x "Jessie".

Resulting debian packages can be installed alongside original system PHP packages or packages from DEB.SURY.ORG repository.

### Install build requirements:

```
apt-get install build-essential devscripts git
apt-get install apache2-dev dh-apache2 autoconf automake bison chrpath debhelper dh-systemd dpkg-dev firebird-dev flex freetds-dev hardening-wrapper libapr1-dev libbz2-dev libc-client-dev libcurl4-openssl-dev libdb-dev libdjvulibre-dev libenchant-dev libevent-dev libexpat1-dev libfreetype6-dev libgcrypt11-dev libgd-dev libglib2.0-dev libgmp3-dev libicu-dev libjpeg-dev libkrb5-dev libldap2-dev libmagic-dev libmcrypt-dev libmhash-dev libmysqlclient-dev libonig-dev libpam0g-dev libpcre3-dev libpng-dev libpq-dev libpspell-dev libqdbm-dev libreadline-dev librecode-dev libsasl2-dev libsnmp-dev libsqlite3-dev libssl-dev libsystemd-dev libtidy-dev libtiff-dev libtool libwrap0-dev libxml2-dev libxmltok1-dev libxslt1-dev locales-all mysql-server netbase netcat-traditional quilt re2c tzdata unixodbc-dev zlib1g-dev
```

### Fix for PHP-IMAP shared module:

```
# Build uw-imap from sources
cd /root
apt-get source uw-imap
cd /root/uw-imap-2007f~dfsg
sed -i 's/libssl-dev/libssl1.0-dev|libssl-dev/g' debian/control debian/rules debian/changelog
sed -i 's/CFLAGS\ +=\ -D_REENTRANT\ -DDISABLE_POP_PROXY/CFLAGS\ +=\ -D_REENTRANT\ -DDISABLE_POP_PROXY\ -fPIC/g' debian/rules
debuild -us -uc -b

# Repack libc-client2007e-dev_2007f_amd64.deb for fix libssl deps
mkdir -p /root/tmp
dpkg-deb -R /root/libc-client2007e-dev_2007f*_amd64.deb /root/tmp
sed -i 's/libssl-dev/libssl1.0-dev|libssl-dev/g' /root/tmp/DEBIAN/control
dpkg-deb -b /root/tmp /root/libc-client2007e-dev_2007f~dfsg-5_amd64.deb
rm -r /root/tmp

# Install uw-imap
cd /root/ && dpkg -i libc-client*.deb mlock*.deb
```

### Clone this branch to your build server:

```
cd /root
git clone https://github.com/s3rj1k/php-debian-jessie-refresh.git
cd /root/php-debian-jessie-refresh
git checkout PHP-5.4.45
```

### Build PHP with enabled tests:

```
debuild -us -uc -b
```

### Build PHP with disabled tests:

```
DEB_BUILD_OPTIONS=nocheck debuild -us -uc -b
```
