#!/bin/bash

# test if we need to run the update scripts
[ "$ADVANCED_DISABLEUPDATES" ] && exit 0
[ "$BASE_APTLIST" ] && APTLIST="$BASE_APTLIST ""$APTLIST"
[ "$APTLIST" ] || exit 0
<<<<<<< HEAD

# run apt-select script to find fastest up to date mirror
cd /defaults
echo "finding fastest mirror"
python3 /app/aptselect/apt-select.py -t 3 -m up-to-date
[[ -f /defaults/sources.list ]] && mv /defaults/sources.list /etc/apt/sources.list

# check for and install any updates
echo "We are now refreshing packages from apt repositories, this *may* take a while"
apt-get update -qq
apt-get --only-upgrade install -yqq $APTLIST || echo "Something went wrong with the update, please try again later" && exit



=======
echo "We are now refreshing packages from apt repositorys, this *may* take a while" 
apt-get update -qq && apt-get --only-upgrade install -yqq $APTLIST
if [ $? -eq 0 ]; then echo "Update: OK "; else echo "Update: ERROR "; fi
>>>>>>> master


