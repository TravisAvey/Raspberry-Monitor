# Welcome to the Raspberry-Monitor Repo!

### This is an ongoing project.  Currently working on developing the iOS application as of March, 2018.

This is a repository on the basics of getting your Raspberry Pi set up with Motion, then configuring port forwarding to view the stream from anywhere in the world.  This will allow you to view your webcam via Android, iOS, or even just a web browser.

### Requirements
* Raspberry Pi or you can run on a linux distro
* Web Cam
* Internet Access
* Access to your router with admin rights

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

You should see a stream coming from your Raspberry PI's webcam in a web browser.

### Port Forwarding

To be able to view this stream from outside your LAN, you will need to set up port forwarding on your router.  I happen to be using Comcast at the time this was made, so I was only able to use a certain range of ports.  You will have to check your ISP and your router to check which ports you can use.

I ended up using port 8081.

