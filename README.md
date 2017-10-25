# Welcome to the Raspberry-Monitor Repo!

This is a repository on the basics of getting your Raspberry Pi set up with Motion, then configuring port forwarding to view the stream from anywhere in the world.  This will allow you to view your webcam via Android, iOS, or even just a web browser.  This guide will aide you in setting up your Pi with motion and optionally create an Android or iOS app to view.  Also, you can optionally send audio from your Android or iOS device to be played on the Pi.

### Requirements
* Raspberry Pi or you can run on a linux distro
* Web Cam
* Internet Access
* Optional: Access to your router with admin rights
* Optional: Android Studio installed
* Optional: A Mac with Xcode installed
* Optional: Speakers

I list the last few as optional, because you can use this with just a browser on your Local Area Network (LAN) nor do you need to send audio to be played on the Pi.

***

## Set up Raspberry Pi && Motion

### Web Cam
Connect your web cam to your Pi, depending on your model you may need to use a powered usb hub as the Pi's power source is only 5 volts.

### IP Address
First you'll need your Pi's ip address:

```shell
$ ifconfig
```

### Enable SSH
You'll also need to enable SSH; it will most likely be disabled by default.

```shell
$ sudo raspi-config
```

### Update the Pi
Now you should update your Pi with:
```shell
$ sudo apt rpi-update
$ sudo apt update
$ sudo apt upgrade
$ sudo apt install git
$ sudo apt install libjpeg-dev
```
This will ensure your Pi is up to date with all the current software.

## Motion

### Install Motion

Run:

```shell
git clone http://github.com/sackmotion/motion 
cd motion
./configure
make
sudo make install 
sudo mv /usr/local/etc/motion-dist.conf /usr/local/etc/motion.conf 
```

press y to accept and install.

### Configure Motion

Motion's config file is quite large.  You may want to turn off the settings that automatically save an image and a video everytime it detects motion.  If you are using a Raspberry Pi without saving to an external location, this might fill your SD card.

Go ahead and set the following settings:

```
daemon on
width 640
height 480
framerate 50
web_localhost off
control_localhost off
```

The last 2 allow the stream to be viewed from anywhere, not just local host.

Save and close the file with your favorite editor such as vim.  Now we can start Motion and view it in your browser.

```shell
$ sudo service start motion
```

Now you go to the IP address we found earlier with the port `8081` that is the default for motion.

```http
http:\\192.168.0.1:8081
```

You should see a stream with what your web cam is pointing at.  If you need to view this from anywhere on the web or in an Android/iOS app, then you can stop here and enjoy having a Raspberry-Monitor for your house or a baby/puppy monitor.

