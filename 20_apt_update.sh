#!/bin/bash

# test conditions for aptlist and base aptilist
[ "$BASE_APTLIST" ] && APTLIST="$BASE_APTLIST ""$APTLIST"
[ "$APTLIST" ] || exit 0


# set our functions
update_apt(){
unset RETVAL
apt-get update -qq
RETVAL="$?"
}

delete_mirrors(){
apt-get clean
rm -rf /var/lib/apt/lists/*
mkdir -p /var/lib/apt/lists/partial
sed -i '/^#/! {/mirrors.ubuntu.com/ s/^/#/}' /etc/apt/sources.list
  }

reset_mirrors(){
sed -i '{/mirrors.ubuntu.com/ s/^#//}' /etc/apt/sources.list
  }

# reset to standard mirror setup
reset_mirrors

echo "We are now refreshing packages from apt repositories, this *may* take a while"

# try apt-get update and output exit code to variable
update_apt

# if update with mirrors failed, sed them out
if [ "$RETVAL" != "0" ]; then
delete_mirrors
update_apt
fi

apt-get --only-upgrade install -yqq $APTLIST




