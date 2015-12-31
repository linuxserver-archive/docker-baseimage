#!/bin/bash


# test conditions for aptlist and base aptilist

[ "$ADVANCED_DISABLEUPDATES" ] && exit 0
[ "$BASE_APTLIST" ] && APTLIST="$BASE_APTLIST ""$APTLIST"
[ "$APTLIST" ] || exit 0

# install apt-select if required
if [ ! -f "/app/apt-select/apt-select.py" ]; then
curl -o /tmp/apt-select.zip -L https://github.com/jblakeman/apt-select/archive/master.zip
cd /tmp
unzip /tmp/apt-select.zip
mv /tmp/apt-master /app/apt-select
fi

# set our functions
update_apt(){
cd /app/apt-select python3 apt-select.py -t 3 -m up-to-date || true
[[ -f /app/apt-select/sources.list ]] && mv /app/apt-select/sources.list /etc/apt/sources.list 
unset RETVAL UPDATE_RETVAL UPGRADE_RETVAL
apt-get update -qq
UPDATE_RETVAL=$?
apt-get --only-upgrade install -yqq $APTLIST
UPGRADE_RETVAL=$?
RETVAL=$((UPDATE_RETVAL+UPGRADE_RETVAL))
}

remove_build_list(){
apt-get clean
rm -rf /var/lib/apt/lists/*
mkdir -p /var/lib/apt/lists/partial
rm /etc/apt/sources.list.d/build.list
  }

# reset to standard mirror setup
[[ -f /etc/apt/sources.list.d/build.list ]] && remove_build_list

echo "We are now refreshing packages from apt repositorys, this *may* take a while"

# try initial update and upgrade.
update_apt


