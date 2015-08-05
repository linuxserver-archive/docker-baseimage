#!/bin/bash
mkdir -p /config/nginx/site-confs /config/www /config/log/nginx /config/keys

if [ ! -f "/config/nginx/nginx.conf" ]; then
cp /defaults/nginx.conf /config/nginx/nginx.conf
fi

if [ ! -f "/config/nginx/nginx-fpm.conf" ]; then
cp /defaults/nginx-fpm.conf /config/nginx/nginx-fpm.conf
fi

if [ ! -f "/config/nginx/site-confs/default" ]; then
cp /defaults/default /config/nginx/site-confs/default
fi

cp /config/nginx/nginx-fpm.conf /etc/php5/fpm/pool.d/www.conf
chown -R abc:abc /config
