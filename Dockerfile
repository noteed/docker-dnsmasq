FROM ubuntu:12.04
MAINTAINER Vo Minh Thu <noteed@gmail.com>

RUN apt-get update
RUN apt-get install -q -y language-pack-en
RUN update-locale LANG=en_US.UTF-8

RUN apt-get install -q -y vim

# Install an SSH server. This is used to update the configuration and
# hot-reload it. Once Docker supports the `cp` command from host to container,
# this can be removed.
run apt-get -q -y install openssh-server
# No idea why this directory is not created, but sshd needs it.
run mkdir /var/run/sshd

add insecure_id_rsa.pub /root/.ssh/authorized_keys
run chown -R root:root /root/.ssh

# Install dnsmasq
RUN apt-get install -q -y dnsmasq

# Pre-configure dnsmasq
RUN echo 'listen-address=__LOCAL_IP__' >> /etc/dnsmasq.conf
RUN echo 'resolv-file=/etc/resolv.dnsmasq.conf' >> /etc/dnsmasq.conf
RUN echo 'conf-dir=/etc/dnsmasq.d'  >> /etc/dnsmasq.conf
RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.dnsmasq.conf
RUN echo 'nameserver 8.8.4.4' >> /etc/resolv.dnsmasq.conf

# This directory will usually be provided with the -v option.
# RUN echo 'address=/example.com/xx.xx.xx.xx' >> /etc/dnsmasq.d/0hosts

# On the other hand the above directory isn't reloaded with a SIGHUP. Instead
# we can use an --addn-hosts file.

RUN touch /etc/addn-hosts
ADD run.sh /root/run.sh
ADD reload.sh /root/reload.sh

EXPOSE 22
EXPOSE 53

CMD /root/run.sh
