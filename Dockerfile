FROM phusion/baseimage:0.9.17
ENV DEBIAN_FRONTEND="noninteractive"HOME="/root" TERM="screen" 
RUN useradd -u 911 -U -s /bin/false abc && usermod -G users abc
