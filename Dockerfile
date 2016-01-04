FROM phusion/baseimage:0.9.18
ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" TERM="xterm" 
RUN useradd -u 911 -U -d /config -s /bin/false abc && usermod -G users abc && mkdir -p /app /config /defaults
RUN mkdir -p /app/aptselect && curl -L https://github.com/jblakeman/apt-select/archive/master.tar.gz | tar xvz -C /app/aptselect --strip-components=1
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN apt-get update && apt-get install -y python3-bs4 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY *.sh /etc/my_init.d/
COPY apt_select /app/aptselect 
RUN chmod +x /etc/my_init.d/*.sh
CMD ["/sbin/my_init"]

