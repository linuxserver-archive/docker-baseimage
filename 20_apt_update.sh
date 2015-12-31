#!/bin/bash

cd /defaults
echo "We are now refreshing packages from apt repositorys, this *may* take a while"
python3 /app/aptselect/apt-select.py -t 3 -m up-to-date
[[ -f /defaults/sources.list ]] && mv /defaults/sources.list /etc/apt/sources.list
apt-get update -qq
apt-get --only-upgrade install -yqq $APTLIST




