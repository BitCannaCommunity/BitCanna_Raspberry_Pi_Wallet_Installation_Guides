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

cd ./boost_1_57_0 && sudo sudo ./bootstrap.sh --with-libraries=all && sudo ./b2 install && cd

6 - Install some dependencies

sudo apt-get install -y build-essential autoconf automake libtool libssl-dev qt4-qmake libqt4-dev libminiupnpc-dev libdb++-dev libdb-dev libcrypto++-dev ufw git software-properties-common autotools-dev pkg-config libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev automake g++-mingw-w64-x86-64 libevent-dev libgmp-dev devscripts libsodium-dev qt5-default

7 - Install working libssl

sudo apt-get remove libssl-dev && sudo nano /etc/apt/sources.list

8 - Change file to look like this:

#deb http://ftp.debian.org/debian/ buster main contrib non-free
#deb http://security.debian.org/ buster/updates main contrib non-free
#deb http://ftp.debian.org/debian/ buster-updates main contrib non-free

deb http://ftp.debian.org/debian/ jessie main contrib non-free
deb http://security.debian.org/ jessie/updates main contrib non-free
deb http://ftp.debian.org/debian/ jessie-updates main contrib non-free

# Uncomment lines below then 'apt-get update' to enable 'apt-get source'
#deb-src http://ftp.debian.org/debian/ buster main contrib non-free
#deb-src http://security.debian.org/ buster/updates main contrib non-free
#deb-src http://ftp.debian.org/debian/ buster-updates main contrib non-free

# This system was installed using small removable media
# (e.g. netinst, live or single CD). The matching "deb cdrom"
# entries were disabled at the end of the installation process.
# For information about how to configure apt package sources,
# see the sources.list(5) manual.

9 - press: "ctrl+x" and then "Y" and "Enter"

10 - run command -> sudo apt-get update && sudo apt-get install libssl-dev && sudo apt-mark hold libssl-dev && sudo apt-mark hold libssl1.0.0 && sudo nano /etc/apt/sources.list

11 - Change file to look like this:

deb http://ftp.debian.org/debian/ buster main contrib non-free
deb http://security.debian.org/ buster/updates main contrib non-free
deb http://ftp.debian.org/debian/ buster-updates main contrib non-free

#deb http://ftp.debian.org/debian/ jessie main contrib non-free
#deb http://security.debian.org/ jessie/updates main contrib non-free
#deb http://ftp.debian.org/debian/ jessie-updates main contrib non-free

# Uncomment lines below then 'apt-get update' to enable 'apt-get source'
#deb-src http://ftp.debian.org/debian/ buster main contrib non-free
#deb-src http://security.debian.org/ buster/updates main contrib non-free
#deb-src http://ftp.debian.org/debian/ buster-updates main contrib non-free

# This system was installed using small removable media
# (e.g. netinst, live or single CD). The matching "deb cdrom"
# entries were disabled at the end of the installation process.
# For information about how to configure apt package sources,
# see the sources.list(5) manual.

12 - press: "ctrl+x" and then "Y" and "Enter"

13 - run command -> sudo apt-get update && sudo apt-get upgrade -y

14 - Install some necessary extra stuff (ZeroMQ Packages, libsodium, Zero MQ itself - https://github.com/MonsieurV/ZeroMQ-RPi)

wget https://github.com/jedisct1/libsodium/releases/download/1.0.3/libsodium-1.0.3.tar.gz && tar -zxvf libsodium-1.0.3.tar.gz && rm libsodium-1.0.3.tar.gz && cd libsodium-1.0.3/ && ./configure && make && sudo make install && cd && wget https://github.com/zeromq/libzmq/releases/download/v4.3.2/zeromq-4.3.2.tar.gz && tar -zxvf zeromq-4.3.2.tar.gz && rm zeromq-4.3.2.tar.gz && cd zeromq-4.3.2/ && ./configure && make && sudo make install && sudo ldconfig 
