# BitCanna Raspberry Pi Wallet Installation Guide
BitCanna Raspberry Pi Wallet Installation Guide

WARNING!

This is still a WiP (Work in Progress) project a lot of changes will be made along the way so use any intrusctions described below at you own risk!!!

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

The following instructions intend that the user (you) already knwo how to at least do the initial Raspeberry Pi setup if not, follow the link to the official guide on how to do the initial installation of the Raspberry Pi.

https://projects.raspberrypi.org/en/projects/raspberry-pi-setting-up

Note: You can skip the update part of the initial RPi instalation process to save time.

All the process will be done using the Terminal, so if you want you can configure your RPi to start/run with just the Command Line Interface (CLI) instead of the regular Desktop Inteface.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
After the initial setup of your RaspberryPi you will need to tweek it a little bit by expanding the disk usage as well as its swap size to do that just follow the steps:

1 - Expand disk space 

1.1 - Use comand -> sudo raspi-config 

1.2 - Go to "Localisation Options"

1.3 - Choose "Change Locale"

1.4 - In the list make sure that at least "en_US.UTF-8 UTF-8" is checked

1.5 - Choose "OK" to build the locales

(if you are running a VM skip to step 1.8)
1.6 - Go to "Advance Options"

1.7 - Choose "Expand Disk Space"

1.8 - Exit the Pi Configuration Tool

1.9 - Select "Yes" when it asks to reboot.

2 - Increase the Swap size:

2.1 - Use command -> sudo nano /etc/dphys-swapfile

2.2 - Locate the line (in white) -> CONF_SWAPSIZE=100

2.3 - Change it to -> CONF_SWAPSIZE=2048

2.4 - press: "ctrl+x" and then "Y" and "Enter"

2.5 - Enable the Swap file with its new size -> sudo dphys-swapfile setup && sudo dphys-swapfile swapon

(This step is not mandatory but it can be usefull to monitoring the RPi behaviour, specially when its compiling, if you don't want skip to Step 4)
3 - Install Webmin (http://www.webmin.com/) and IP Tables to enable firewall access to Webmin

3.1 - Install the follwoing dependencies -> sudo apt-get --fix-broken install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python

3.2 - Install Webmin with -> wget http://prdownloads.sourceforge.net/webadmin/webmin_1.953_all.deb && sudo dpkg --install webmin_1.953_all.deb

3.3 - Install iptables -> sudo apt-get install iptables

3.4 - Add Firewall rule to open port 1000 with -> -A INPUT -p tcp -m tcp --dport 10000 -j ACCEPT

3.5 - Save changes with -> sudo /sbin/iptables-save

3.6 - Connect to RPi on Webmin using YOUR_RPi_IP:10000, then login using your RPi credentials

4 - Update RPi with -> sudo apt-get update && sudo apt-get upgrade -y 

5 - Install Boost Libraries with the follwoing command:

https://www.boost.org/doc/libs/1_57_0/more/getting_started/unix-variants.html#the-boost-distribution

5.1 - Download with -> wget https://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.gz

5.2 - Extract with -> tar -xzvf ./boost_1_57_0.tar.gz && rm ./boost_1_57_0.tar.gz

5.3 - enter boost folder (need to change boost folder permisition)

cd ./boost_1_57_0 && sudo sudo ./bootstrap.sh --with-libraries=all && sudo ./b2 install




6 - Install some dependencies

 
