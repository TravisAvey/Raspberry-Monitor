#!/bin/bash

# install the raspberry pi updater
sudo apt-get install rpi-update -y

# run the raspberry pi updater
sudo rpi-update

# update the repositories
sudo apt-get update

# install the repositories
sudo apt-get upgrade -y

