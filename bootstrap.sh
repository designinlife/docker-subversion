#!/bin/sh

set -e

tz=${TZ:-UTC}
tz=${tz/\//\\/}

export TZ="$tz"

[ ! -d "/var/svn/repos" ] && mkdir -p /var/svn/repos
[ ! -d "/var/svn/conf" ] && mkdir -p /var/svn/conf
[ ! -d "/var/svn/logs" ] && mkdir -p /var/svn/logs

if [ ! -f "/var/svn/conf/passwd" ]; then
    echo "[users]" >/var/svn/conf/passwd
    echo "lilei = 123456" >>/var/svn/conf/passwd

    echo "Initialized. (passwd)"
fi

if [ ! -f "/var/svn/conf/authz" ]; then
    echo "[groups]" >/var/svn/conf/authz
    echo "developer = lilei" >>/var/svn/conf/authz
    echo "" >>/var/svn/conf/authz
    echo "[/]" >>/var/svn/conf/authz
    echo "@developer = r" >>/var/svn/conf/authz
    echo "lilei = rw" >>/var/svn/conf/authz

    echo "Initialized. (authz)"
fi

exec /usr/bin/svnserve -d --foreground --compression 0 --root /var/svn/repos --config-file /etc/svnserve.conf --log-file /var/svn/logs/svnd.log --listen-port 3690
