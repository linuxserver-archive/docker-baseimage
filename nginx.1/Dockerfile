FROM linuxserver/baseimage
MAINTAINER smdion <me@seandion.com>, Mark Burford <sparklyballs@gmail.com>, Stian Larsen <lonix@linuxserver.io>, Kode <kodestar@linuxserver.io>
EXPOSE 80 443
VOLUME /config
RUN apt-get update && 
apt-get install nginx openssl php5-fpm php5 php5-cli -qy && \
apt-get clean -y && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /config/www
RUN mkdir -p /defaults
ADD defaults/index.html /config/www/
ADD defaults/ /defaults/ 
ADD services/ /etc/service/
ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh
