#!/bin/bash


APTLIST="$APTLIST""$BASE_APTLIST"

[ "$APTLIST" ] && (apt-get update && apt-get apt-get --only-upgrade install -yqq "$APTLIST")