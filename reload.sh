#!/bin/bash

# Cause our /etc/addn-hosts file to be reloaded, yay.
kill -HUP `pgrep dnsmasq`
