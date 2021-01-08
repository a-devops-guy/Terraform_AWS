#!/bin/bash

set -xe

#update OS
sudo apt-get update -y
sudo apt-get upgrade -y

#install dependencies 
sudo curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
sudo curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get install -y nodejs gcc g++ make
sudo apt-get -y update && sudo apt-get -y install yarn
sudo apt-get install python2 -y
sudo apt-get remove python3 -y

sudo su
sudo mkdir $VUE_API_PATH/vue-sf-api
cd $VUE_API_PATH/vue-sf-api
sudo git init
sudo git remote add origin https://$GIT_UN:$GIT_TOKEN@$GIT_URL
sudo git pull origin $GIT_BRANCH 
sudo npm i -g pm2
sudo yarn install

cd /src/themes/capybara
sudo yarn install
sudo yarn build

cd /home/kiran/$VUE_API_PATH/vue-sf-api
sudo yarn build
sudo yarn start
