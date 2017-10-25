#!/bin/bash

echo "Updating your Raspberry Pi"

# install the raspberry pi updater
sudo apt-get install rpi-update -y

# run the raspberry pi updater
sudo rpi-update

# update the repositories
sudo apt-get update

# install the repositories
sudo apt-get upgrade -y

# install git to get the most up to date version of motion
sudo apt-get install git

# install a library depencency for motion
sudo apt-get install libjpeg-dev

# get the ip address
ip="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"

echo "Your IP address is $(ip)"
echo "Installing motion"

# clone the most up to date version of motion
git clone http://github.com/sackmotion/motion 
# change directory
cd motion
# gets software ready to build
./configure
# builds the source code with make
make
# install
sudo make install 
# move the config file to the user config location
sudo mv /usr/local/etc/motion-dist.conf /usr/local/etc/motion.conf
