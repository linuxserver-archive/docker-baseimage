#!/bin/bash


[ "$BASE_APTLIST" ] && APTLIST="$BASE_APTLIST ""$APTLIST"
[ "$APTLIST" ] && (echo "We are now refreshing packages from apt repositorys, this *may* take a while" && apt-get update -qq && apt-get --only-upgrade install -yqq $APTLIST)
sleep 1s
