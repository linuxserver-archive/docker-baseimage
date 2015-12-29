FROM phusion/baseimage:0.9.18
ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" TERM="xterm" 
RUN useradd -u 911 -U -d /config -s /bin/false abc && usermod -G users abc && mkdir -p /app /config /defaults
COPY sources.list* /etc/apt/
COPY failover.list* /defaults/
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY *.sh /etc/my_init.d/
RUN chmod +x /etc/my_init.d/*.sh
CMD ["/sbin/my_init"]
