#!/bin/bash

# Thanks to https://github.com/amplab/docker-scripts/blob/master/dnsmasq-precise/files/default_cmd

# Discover our IP address from within the running container...
IP=$(ip -o -4 addr list eth0 | perl -n -e 'if (m{inet\s([\d\.]+)\/\d+\s}xms) { print $1 }')

# ... and sets dsnmasq listening address with it prior to ...
sed -i s/__LOCAL_IP__/$IP/ /etc/dnsmasq.conf

# ... run it.
dnsmasq

# Let the container live.
while [ 1 ];
do
  sleep 10
done
