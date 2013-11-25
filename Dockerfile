FROM ubuntu:12.04
MAINTAINER Vo Minh Thu <noteed@gmail.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list # 20103-08-24
RUN apt-get update
RUN apt-get install -q -y language-pack-en
RUN update-locale LANG=en_US.UTF-8

RUN apt-get install -q -y vim

# Install dnsmaqk
RUN apt-get install -q -y dnsmasq

# Configure dnsmasq
RUN echo 'listen-address=__LOCAL_IP__' >> /etc/dnsmasq.conf
RUN echo 'resolv-file=/etc/resolv.dnsmasq.conf' >> /etc/dnsmasq.conf
RUN echo 'conf-dir=/etc/dnsmasq.d'  >> /etc/dnsmasq.conf
RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.dnsmasq.conf
RUN echo 'nameserver 8.8.4.4' >> /etc/resolv.dnsmasq.conf

# This directory will usually be provided with the -v option.
# RUN echo 'address=/example.com/xx.xx.xx.xx' >> /etc/dnsmasq.d/0hosts

ADD set-listen-address-and-run.sh /root/set-listen-address-and-run.sh

EXPOSE 53

CMD ["/root/set-listen-address-and-run.sh"]
