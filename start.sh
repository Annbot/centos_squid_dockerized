#!/bin/bash

if [ ! -d ${SQUID_CACHE_LOC}/00 ]; then
    echo "Init cache location ....."
    /usr/sbin/squid -N -f /etc/squid/squid.conf -z
fi
echo "Starting squid ....."
exec /usr/sbin/squid -f /etc/squid/squid.conf -NYCd 1
