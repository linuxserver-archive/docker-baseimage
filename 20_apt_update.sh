#!/bin/bash


# test conditions for aptlist and base aptilist

[ "$ADVANCED_DISABLEUPDATES" ] && exit 0
[ "$BASE_APTLIST" ] && APTLIST="$BASE_APTLIST ""$APTLIST"
[ "$APTLIST" ] || exit 0


# set our functions
update_apt(){
unset RETVAL UPDATE_RETVAL UPGRADE_RETVAL
apt-get update -qq
UPDATE_RETVAL=$?
apt-get --only-upgrade install -yqq $APTLIST
UPGRADE_RETVAL=$?
RETVAL=$((UPDATE_RETVAL+UPGRADE_RETVAL))
}

delete_mirrors(){
apt-get clean
rm -rf /var/lib/apt/lists/*
mkdir -p /var/lib/apt/lists/partial
cp /defaults/failover.list /etc/apt/sources.list.d/failover.list
sed -i '/^#/! {/mirrors.ubuntu.com/ s/^/#/}' /etc/apt/sources.list
  }

reset_mirrors(){
  apt-get clean
rm -rf /var/lib/apt/lists/*
mkdir -p /var/lib/apt/lists/partial
[[ -f /etc/apt/sources.list.d/failover.list ]] && rm /etc/apt/sources.list.d/failover.list
sed -i '{/mirrors.ubuntu.com/ s/^#//}' /etc/apt/sources.list
  }

# reset to standard mirror setup
reset_mirrors

echo "We are now refreshing packages from apt repositorys, this *may* take a while"

# try initial update and upgrade.
update_apt

# if update with mirrors failed, sed them out
if [ "$RETVAL" != "0" ]; then
delete_mirrors
update_apt
else
exit 0
fi

