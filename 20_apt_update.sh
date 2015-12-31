#!/bin/bash

[ "$ADVANCED_DISABLEUPDATES" ] && exit 0
[ "$BASE_APTLIST" ] && APTLIST="$BASE_APTLIST ""$APTLIST"
[ "$APTLIST" ] || exit 0

cd /defaults
echo "finding fastest mirror"
python3 /app/aptselect/apt-select.py -t 3 -m up-to-date
[[ -f /defaults/sources.list ]] && mv /defaults/sources.list /etc/apt/sources.list

echo "We are now refreshing packages from apt repositorys, this *may* take a while"
apt-get update -qq
apt-get --only-upgrade install -yqq $APTLIST




