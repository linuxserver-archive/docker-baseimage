FROM alpine:3.3
MAINTAINER liunxserver.io
ENV HOME="/root" TERM="xterm"
ENTRYPOINT ["/init"]
COPY root /
RUN apk add --no-cache bash curl tzdata tar xz && \
apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing shadow && \
groupmod -g 1000 users && \
useradd -u 911 -U -d /config -s /bin/false abc && \
usermod -G users abc && \
curl -L https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz | tar xvz -C / 

