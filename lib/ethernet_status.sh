#!/bin/sh

IFACE=$(/usr/sbin/ifconfig | grep w | awk '{print $1}' | tr -d ':')

if [ "$IFACE" ]; then
    echo "$(/usr/sbin/ifconfig "$IFACE" | grep "inet " | awk '{print $2}')"
else
    echo "Disconnected"
fi
