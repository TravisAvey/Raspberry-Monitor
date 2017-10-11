# Welcome to the Raspberry-Monitor Repo!

This is a repository on the basics of getting your Raspberry Pi set up with Motion, then configuring port forwarding to view the stream from anywhere in the world.  When trying to set this up, I couldn't find a single blog/tutorial that had this entire set up for creating an Android or iOS app.  So I decided to put it all in on location.  

### Requirements
* Raspberry Pi or you can run on a linux distro
* Web Cam
* Internet Access
* Optional: Access to your router with admin rights
* Optional: Android Studio installed
* Optional: A Mac with Xcode installed

I list the last few as optional, because you can use this with just a browser on your Local Area Network (LAN).

***

## Set up Raspberry Pi

### Web Cam
Connect your web cam to your Pi, depending on your model you may need to use a powered usb hub as the PI's power source is only 5 volts.

### IP Address
You'll need to power on your Pi and connect to the internet.  I run my Pi headless, where I SSH into it and run commands from a terminal.  First you'll need your Pi's ip address:

`$ ifconfig`

This will spit out a bunch of info, you are looking for a line that looks like:

`inet 192.168.0.1 netmask 255.255.255.0 broadcast 192.168.0.255`

Write down the inet address; this is your internal LAN ip address.

### Enable SSH
You'll also need to enable SSH; it will most likely be disabled by default.

`$ sudo raspi-config`

This will open a dialog window to config your Pi.  You may want to change your default password here and other various configurations.  To enable SSH, select `5 Interfacing Options` and then `P2 SSH`

Then you can SSH into your Pi from Windows (I use [Git Bash](https://git-scm.com/download/win) for Windows) or any Unix/Linux computer on your LAN.

`$ ssh pi@192.168.0.1`

Note: This is the IP address you got from `ifconfig`.  It will prompt for the password, the default is probably `raspberry` if you are running Raspbian.  Otherwise, you'll need to check the instructions from where you downloaded the Raspberry image from.

### Update the Pi
Now you should update your Pi with:

`$ sudo apt rpi-update`

`$ sudo apt update`

`$ sudo apt upgrade`

This will ensure your Pi is up to date with all the current software.

## Motion

### Install Motion

Run:

`$ sudo apt install motion`

press y to accept and install.

### Configure Motion

Motion's config file is quite large.  You may want to turn off the settings that automatically save an image and a video everytime it detects motion.  If you are using a Raspberry Pi without saving to an external location, this might fill your SD card.

Go ahead and set the following settings:

This allows Motion to run as a daemon, to run in the background

`daemon on`

Set the height and width to your desires.

`width 640`

`height 480`


Set the framerate to a desired rate

`framerate 50`

To allow the stream to be viewed off the LAN

`web_localhost off`

and

`control_localhost off`

Save and close the file with your favorite editor such as vim.  Now we can start Motion and view it in your browser.

`$ sudo service start motion`

Now you go to the IP address we found earlier with the port `8081` that is the default for motion.

`192.168.0.1:8081`

You should see a stream with what your web cam is pointing at.  If you don't care to view this from anywhere on the web or in an Android/iOS app, then you can stop here and enjoy having a security monitor for your house or a baby/puppy monitor.

