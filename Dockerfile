# Mongodb
#
# VERSION               0.2

FROM ubuntu:latest
MAINTAINER Allisson Azevedo <allisson@gmail.com>

# avoid debconf and initrd
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# install packages
RUN echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" >> /etc/apt/source.list
RUN apt-get update
RUN apt-get install -y openssh-server mongodb-10gen supervisor

# make /var/run/sshd
RUN mkdir /var/run/sshd

# setup mongodb
RUN mkdir -p /data/db

# set root password
RUN echo "root:root" | chpasswd

# clean packages
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# expose mongodb port
EXPOSE 22 27017

# copy supervisor conf
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# start supervisor
CMD ["/usr/bin/supervisord"]
