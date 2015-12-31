#!/bin/bash


# test conditions for aptlist and base aptilist

[ "$ADVANCED_DISABLEUPDATES" ] && exit 0
[ "$BASE_APTLIST" ] && APTLIST="$BASE_APTLIST ""$APTLIST"
[ "$APTLIST" ] || exit 0


# set our functions
update_apt(){
# unset RETVAL UPDATE_RETVAL UPGRADE_RETVAL
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
# [[ -f /etc/apt/sources.list.d/build.list ]] && remove_build_list

echo "We are now refreshing packages from apt repositorys, this *may* take a while"

# try initial update and upgrade.
update_apt


