#!/bin/bash

# test conditions for aptlist and base aptilist
[ "$BASE_APTLIST" ] && APTLIST="$BASE_APTLIST ""$APTLIST"
[ "$APTLIST" ] || exit 0

# set our functions
reset_mirrors(){
[[ -f /etc/apt/sources.list.d/backup_sources.list ]] && rm /etc/apt/sources.list.d/backup_sources.list
sed -i '{/mirrors.ubuntu.com/ s/^#//}' /etc/apt/sources.list
  }

delete_mirrors(){
cp /defaults/backup_sources.list /etc/apt/sources.list.d/backup_sources.list 
sed -i '/^#/! {/mirrors.ubuntu.com/ s/^/#/}' /etc/apt/sources.list  
  }


# reset to standard mirror setup
reset_mirrors

echo "We are now refreshing packages from apt repositorys, this *may* take a while"

# try apt-get update and output exit code to variable
unset RETVAL
apt-get clean
apt-get update -qq 
RETVAL=$?

# if update with mirrors failed, try backup list
if [ "$RETVAL" -gt "0" ]; then
delete_mirrors
apt-get clean
apt-get update -qq
fi

apt-get --only-upgrade install -yqq $APTLIST
