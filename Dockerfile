FROM ubuntu:16.04
MAINTAINER lonix
ENV HOME="/root" TERM="xterm"
ENTRYPOINT ["/init"]
COPY root /
RUN && \
ARG DEBIAN_FRONTEND="noninteractive" 
useradd -u 911 -U -d /config -s /bin/false abc && \
usermod -G users abc && \
mkdir -p /app/aptselect /config /defaults && \
curl -L https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz | tar xvz -C / && \
curl -L https://github.com/jblakeman/apt-select/archive/v0.1.1.tar.gz | tar xvz -C /app/aptselect --strip-components=1 && \
apt-get update && \
apt-get install -y python3-bs4 && \
apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*