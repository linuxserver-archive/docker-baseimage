#!/bin/bash


[ "$BASE_APTLIST" ] && APTLIST="$BASE_APTLIST ""$APTLIST"
[ "$APTLIST" ] && (apt-get update -qq && apt-get --only-upgrade install -yqq $APTLIST)
sleep 1s
