FROM ubuntu:16.04
MAINTAINER lonix
ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" TERM="xterm"
ENTRYPOINT ["/init"]
COPY root /

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz
RUN tar xvfz /tmp/s6-overlay.tar.gz -C / && \
useradd -u 911 -U -d /config -s /bin/false abc && \
usermod -G users abc && \
apt-get -q update && \
apt-get install -qy dbus gdebi-core avahi-daemon wget curl && \
PLEXURL=$(curl -s https://tools.linuxserver.io/latest-plex.json| grep "ubuntu64" | cut -d '"' -f 4) && \
wget -P /tmp "$PLEXURL" && \
gdebi -n /tmp/plexmediaserver_*_amd64.deb && \
rm -f /tmp/plexmediaserver_*_amd64.deb && \
apt-get clean &&rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
cp -v /default/plexmediaserver /etc/default/plexmediaserver
