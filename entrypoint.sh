#!/bin/sh

/mergerfs.sh

/usr/sbin/crond -d 6 -c /etc/crontabs -f
