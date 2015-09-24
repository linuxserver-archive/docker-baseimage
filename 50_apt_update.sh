#!/bin/bash


APTLIST="$BASE_APTLIST""$APTLIST"

[ "$APTLIST" ] && (apt-get update && apt-get apt-get --only-upgrade install -yqq "$APTLIST")