#!/bin/bash

set -x

#update OS
sudo apt-get update -y
sudo apt-get upgrade -y

#install dependencies
sudo apt-get install nginx -y

curl -L https://packagecloud.io/varnishcache/varnish41/gpgkey | sudo apt-key add -
sudo nano /etc/apt/sources.list.d/varnishcache_varnish41.list	
deb https://packagecloud.io/varnishcache/varnish41/ubuntu/ trusty main
deb-src https://packagecloud.io/varnishcache/varnish41/ubuntu/ trusty main
sudo apt-get update -y
sudo apt-get install varnish -y

#start service on system boot
sudo systemctl enable nginx
sudo systemctl enable varnish

#enable varnish and nginx config
sudo cp /etc/varnish/default.vcl /etc/varnish/default.vcl.bak
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/elb_dns.conf /etc/nginx/sites-enabled/elb_dns.conf

#reboot service
sudo systemctl restart nginx
sudo systemctl restart varnish