#!/usr/bin/env bash
# List of commands to setup UFW to block all incoming traffic excepts
# those going through TCP ports 22, 443, & 80. Also configure port forwarding.

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable

sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 22/tcp

# Port forwarding config
sudo echo -e "net.ipv4.ip_forward=1\n" >> /etc/ufw/sysctl.conf

sudo printf '\n%s\n' "*nat
:PREROUTING ACCEPT [0:0]
-A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-port 80
COMMIT" >> /etc/ufw/before.rules

sudo ufw allow 8080/tcp
