#!/bin/sh

set -eu

[ $# -ge 2 ] || {
    echo "Usage: debian/setup-mysql.sh port data-dir" >&2
    exit 1
}

# CLI arguments #
port=$1
datadir=$2
action=${3:-start}
if [ "$(id -u)" -eq 0 ]; then
    user="mysql"
else
    user="$(whoami)"
fi

# Some vars #

socket=$datadir/mysql.sock
# Commands:
mysqladmin="mysqladmin --no-defaults --user root --port $port --host 127.0.0.1 --socket=$socket --no-beep"
mysqld="/usr/sbin/mysqld --no-defaults --user=$user --bind-address=127.0.0.1 --port=$port --socket=$socket --datadir=$datadir --skip-grant-tables"

# Main code #

if [ "$action" = "stop" ]; then
    $mysqladmin shutdown
    exit
fi

rm -rf $datadir
mkdir -p $datadir
chmod go-rx $datadir
chown $user: $datadir

mysqld_path=$(whereis -b mysqld | cut -f2 -d" ")

if mysql --version | grep -iq "Distrib 5.7." ; then
    mysql_install_db --no-defaults --user=$user --datadir=$datadir --mysqld-file=$mysqld_path
else
    mysql_install_db --no-defaults --user=$user --datadir=$datadir --rpm --force
fi

tmpf=$(mktemp)
if mysql --version | grep -iq "Distrib 5.7." ; then
cat > "$tmpf" <<EOF
FLUSH PRIVILEGES;
USE mysql;
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
FLUSH PRIVILEGES;
CREATE DATABASE test;
EOF
else
cat > "$tmpf" <<EOF
FLUSH PRIVILEGES;
USE mysql;
UPDATE user SET password=PASSWORD('') WHERE user='root';
FLUSH PRIVILEGES;
CREATE DATABASE test;
EOF
fi

$mysqld --bootstrap --skip-grant-tables < "$tmpf"

unlink "$tmpf"

# Start the daemon
$mysqld &

pid=$!

# Wait for the server to be actually available
c=0;
while ! nc -z 127.0.0.1 $port; do
    c=$(($c+1));
    sleep 3;
    if [ $c -gt 20 ]; then
	echo "Timed out waiting for mysql server to be available" >&2
	if [ "$pid" ]; then
	    kill $pid || :
	    sleep 2
	    kill -s KILL $pid || :
	fi
	exit 1
    fi
done

# Check if the server is running
$mysqladmin status
# Drop the database if it exists
$mysqladmin --force --silent drop test || true
# Create new empty database
$mysqladmin create test
