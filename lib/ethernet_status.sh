#!/bin/sh

IFACE=$(/usr/sbin/ifconfig | grep w | awk '{print $1}' | tr -d ':')

if [ "$IFACE" ]; then
    echo "%{F#2495e7}󰈀 %{F#ffffff}$(/usr/sbin/ifconfig "$IFACE" | grep "inet " | awk '{print $2}')%{u-}"
else
    echo "%{F#1bbf3e} %{u-} Disconnected"
fi