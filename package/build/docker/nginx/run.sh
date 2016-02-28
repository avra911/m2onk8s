#!/bin/sh

# Overwrite the DNS resolver to use the one in the local address space
echo "namesever 127.0.0.1" > /etc/resolve.conf

cat /etc/resolv.conf > /proc/self/fd/1

# [CMD]
nginx -g "deamon off"
