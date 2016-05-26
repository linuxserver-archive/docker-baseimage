FROM alpine:3.3
MAINTAINER liunxserver.io
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/root" TERM="xterm"
ENTRYPOINT ["/init"]
COPY root /
RUN useradd -u 911 -U -d /config -s /bin/false abc && \
usermod -G users abc && \
apk add --no-cache bash curl tzdata tar && \
apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing shadow && \
curl -L https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz | tar xvz -C / && \
