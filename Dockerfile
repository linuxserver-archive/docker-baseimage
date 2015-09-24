FROM phusion/baseimage:0.9.17
ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" TERM="screen" 
RUN useradd -u 911 -U -s /bin/false abc && usermod -G users abc && mkdir -p /app /config /defaults
ADD sources.list /etc/apt/sources.list
ADD 10_add_user_abc.sh /etc/my_init.d/10_add_user_abc.sh 
ADD 50_apt_update.sh /etc/my_init.d/50_apt_update.sh
RUN chmod +x /etc/my_init.d/10_add_user_abc.sh /etc/my_init.d/50_apt_update.sh
CMD ["/sbin/my_init"]
