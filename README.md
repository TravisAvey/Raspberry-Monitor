# Welcome to the Raspberry-Monitor Repo!

This is a repository on the basics of getting your Raspberry Pi set up with Motion, then configuring port forwarding to view the stream from anywhere in the world.  Android and iOS basic set up is shown.  From here you can configure to whatever you need.

***

## Set up Raspberry Pi

### IP Address
You'll need to power on your Pi and connect to the internet.  I run my Pi headless, where I SSH into it and run commands from a terminal.  First you'll need your Pi's ip address:

`pi$ ifconfig`

This will spit out a bunch of info, you are looking for a line that looks like:

`inet 192.168.0.1 netmask 255.255.255.0 broadcast 192.168.0.255`

Write down the inet address; this is your internal LAN ip address.

### Enable SSH
You'll also need to enable SSH; it will most likely be disabled by default.

`$ sudo raspi-config`

This will open a dialog window to config your Pi.  You may want to change your default password here and other various configurations.  To enable SSH, select `5 Interfacing Options` and then `P2 SSH`.

Then you can SSH into your Pi from Windows (I use [Git Bash](https://git-scm.com/download/win) for Windows) or any Unix/Linux computer on your LAN.

`$ ssh pi@192.168.0.1`

Note: This is the IP address you got from `ifconfig`.  It will prompt for the password, the default is probably `raspberry` if you are running Raspbian.  Otherwise, you'll need to check the instructions from where you downloaded the Raspberry image from.

### Update the Pi
Now you should update your Pi with:

`$ sudo apt rpi-update`

`$ sudo apt update`

`$ sudo apt upgrade`

This will ensure your Pi is up to date with all the current software.
