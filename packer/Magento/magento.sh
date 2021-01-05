#!/bin/bash

set -x

#update OS
sudo apt-get update -y
sudo apt-get upgrade -y

#install dependencies 
sudo apt-get install nginx -y
sudo apt-get install apache2 -y
sudo apt-get install php php-fpm php-cli
sudo apt-get install php7.4-bcmath php7.4-ctype php7.4-curl php7.4-dom php7.4-gd php7.4-iconv php7.4-json php7.4-intl php7.4-mbstring php7.4-mysql php7.4-simplexml php7.4-soap php7.4-xml php7.4-xsl php7.4-zip php7.4-sockets php7.4-pdo php7.4-mysqlnd php7.4-opcache
sudo apt-get autoremove -y
sudo apt-get install zip unzip

#nginx config
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/elb_dns.conf /etc/nginx/sites-enabled/elb_dns.conf

#start/stop services on system boot
sudo systemctl enable nginx
sudo systemctl enable php7.4-fpm
sudo systemctl disable apache2

#reboot/stop services
sudo systemctl restart nginx
sudo systemctl restart php7.4-fpm
sudo systemctl stop apache2

#install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --filename=composer --version=1.10.19 --install-dir=/usr/local/bin/

#install magento
sudo mkdir $1/magento 
sudo cd $1/magento
sudo git init
sudo git remote add origin https://$2:$3@$4 
sudo git pull origin $5 
sudo composer install
#git remote add origin https://un:token@github.com/un/repo.git
#Convert into ASCII in case the username contain the Alphanumeric

#file & folder permission
sudo find var generated vendor pub/static pub/media app/etc -type f -exec chmod u+w {} +
sudo find var generated vendor pub/static pub/media app/etc -type d -exec chmod u+w {} +
sudo chmod u+x bin/magento
sudo cd ..
chown -R :www-data