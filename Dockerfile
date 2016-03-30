FROM ubuntu:16.04
MAINTAINER lonix
ENV HOME="/root" TERM="xterm"
ENTRYPOINT ["/init"]
COPY root /
ARG DEBIAN_FRONTEND="noninteractive" 

RUN useradd -u 911 -U -d /config -s /bin/false abc
RUN usermod -G users abc
RUN mkdir -p /app/aptselect
RUN curl -L https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz | tar xvz -C /
RUN curl -L https://github.com/jblakeman/apt-select/archive/v0.1.1.tar.gz | tar xvz -C /app/aptselect --strip-components=1
RUN apt-get update
RUN apt-get install -y python3-bs4
RUN apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*