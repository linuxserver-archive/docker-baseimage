#!/bin/bash

[ "$ADVANCED_DISABLEUPDATES" ] && exit 0
[ "$BASE_APTLIST" ] && APTLIST="$BASE_APTLIST ""$APTLIST"
[ "$APTLIST" ] || exit 0
echo "We are now refreshing packages from apt repositorys, this *may* take a while" 
apt-get update -qq && apt-get --only-upgrade install -yqq $APTLIST
if [ $? -eq 0 ]; then echo "Update: OK "; else echo "Update: ERROR "; fi


