#!/bin/bash

apt-get update -qq
apt-get --only-upgrade install \
nginx \
openssl \
php5-fpm \
php5 \
php5-cli -qqy
