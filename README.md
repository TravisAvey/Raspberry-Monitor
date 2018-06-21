# Welcome to the Raspberry-Monitor Repo!

### This is an ongoing project.  Currently working on developing the iOS application as of June, 2018.

This is a repository on the basics of getting your Raspberry Pi set up with Motion, then configuring port forwarding to view the stream from anywhere in the world.  This will allow you to view your webcam via Android, iOS, or even just a web browser.

### Requirements
* Raspberry Pi or you can run on a linux distro
* Web Cam
* Internet Access
* Access to your router with admin rights

### Remember to save the following
* Public IP address with port number
* Username and Password set for Motion and Apache

The above will be used to access your feed outside your LAN, from either Android/iOS app or a web browser.

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

I set the following settings, you can change the width, height, and framerate to your desires.  But daemon and the localhost controls should be set as:

```
daemon on
width 1920
height 1080
framerate 100

# allows to view from outside of LAN
web_localhost off
control_localhost off

# turn off auto storing images
output_pictures off
output_debug_pictures off

# turn off auto recording mpegs (Pi will fill up fast!)
ffmpeg_output_movies off
ffmpeg_output_debug_movies off

# it is possible to set up another store location (separate HDD, NAS) if you need to store the videos and images
target_dir /path/to/large/storage

# set a username password
stream_authentication username:password

```



Save and close the file with your favorite editor such as vim.  Now we can start Motion and view it in your browser.

```shell
$ sudo service start motion
```

Now you go to the IP address we found earlier with the port `8081` that is the default for motion.

```http
http:\\192.168.0.1:8081
```

You should see a stream coming from your Raspberry PI's webcam in a web browser.

### Set up a Web Server

I chose to use Apache, Nginx or others will work as long as you can configure it to listen to the port `8081`

```shell
$ sudo apt install apache2
```

Edit the port:
```shell
$ sudo vim /etc/apache2/ports.conf
# change from 80 to 8081 (or which port you will use)
Listen 8081
```

Now to make this viewable in a web browser:

```shell
$ sudo vim /var/www/index.html
```

```html
<iframe src='http://<pi-url>:8081' height='1080' width='1920'></iframe>
```

Now you should point your browser to the Pi's url:8081 and see the feed.  It should require the username and password that was set earlier.

Although we set a password on Motion, it is wise to secure the server also.  I used an .htaccess file in my index.html file location.

```shell
$ sudo apt install apache2-utils

# set up a new username:password (I used the same combination from earlier, as the Android app will require the username password)
sudo htpasswd -c /etc/apache2/.htpasswd username

# create the .htaccess file
$ sudo vim /var/www/.htaccess

# use the following settings
AuthType Basic
AuthName "Restricted Content"
AuthUserFile /etc/apache2/.htpasswd
Require valid-user

# save and exit and restart apache
$ sudo service apache2 restart
```


### Port Forwarding

To be able to view this stream from outside your LAN, you will need to set up port forwarding on your router.  I happen to be using Comcast at the time this was made, so I was only able to use a certain range of ports.  You will have to check your ISP and your router to check which ports you can use.  Change the port forwarding for the Pi's IP address to the port we used above.

Find the outward facing IP address from your router using a service like [What is my ip address](http://whatismyipaddress.com).  Now with your public IP address and port forwarding enabled, you should see Motion's live feed at http://<Public-IP>:8081.  This will be the IP address to use in the Android App with the username and password set in above steps.


