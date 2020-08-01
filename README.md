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

1.1 - Use comand 

sudo raspi-config 

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

2.1 - Use command 

sudo nano /etc/dphys-swapfile

2.2 - Locate the line (in white) -> CONF_SWAPSIZE=100

2.3 - Change it to -> CONF_SWAPSIZE=2048

2.4 - press: "ctrl+x" and then "Y" and "Enter"

2.5 - Enable the Swap file with its new size 

sudo dphys-swapfile setup && sudo dphys-swapfile swapon && sudo chmod -R a+rwx ./

(This step is not mandatory but it can be usefull to monitoring the RPi behaviour, specially when its compiling, if you want you can skip to Step 4)
3 - Install Webmin (http://www.webmin.com/) and IP Tables to enable firewall access 

3.1 - Install dependencies 

sudo apt-get --fix-broken install -y perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python

3.2 - Download  and Install Webmin

wget http://prdownloads.sourceforge.net/webadmin/webmin_1.953_all.deb && sudo dpkg --install webmin_1.953_all.deb && rm webmin_1.953_all.deb

3.3 - Install iptables 

sudo apt-get install iptables

3.4 - Add Firewall rule to open port 10000

sudo iptables -A INPUT -p tcp -m tcp --dport 10000 -j ACCEPT && sudo /sbin/iptables-save

3.5 - Connect to RPi on Webmin using YOUR_RPi_IP:10000, then login using your RPi credentials

4 - Update and Upgrade the RPi 

sudo apt-get update && sudo apt-get upgrade -y 

5 - Compiling and Installing Boost Libraries ver. 1.57

5.1 - Download the Boost Libraries, uncompress it, and cd into the uncompressed directory

wget https://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.gz && tar -xzvf boost_1_57_0.tar.gz && rm boost_1_57_0.tar.gz && sudo chmod -R a+rwx boost_1_57_0/ && cd boost_1_57_0/ 

5.2 - Then, configure the system for compiling, do the actual compile job with make (will take a good while), and then install Boost Libraries

sudo ./bootstrap.sh --with-libraries=all && sudo ./b2 install

5.3 - Exit the folder

cd

6 - Install some dependencies

sudo apt-get install -y build-essential autoconf automake libtool libssl-dev qt4-qmake libqt4-dev libminiupnpc-dev libdb++-dev libdb-dev libcrypto++-dev ufw git software-properties-common autotools-dev pkg-config libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev automake g++-mingw-w64-x86-64 libevent-dev libgmp-dev devscripts libsodium-dev qt5-default

7 - Install a working libssl

7.1 - Remove current libssl and edit RPi sources file

sudo apt-get remove -y libssl-dev && sudo nano /etc/apt/sources.list

7.2 - Change "buster" to "jessie" 

7.3 - Press

"ctrl+x" > "Y" > "Enter"

7.4 - Update and Install libssl-dev, mark and hold it, and edit RPi sources file again 

sudo apt-get update && sudo apt-get install -y libssl-dev && sudo apt-mark hold libssl-dev && sudo apt-mark hold libssl1.0.0 && sudo nano /etc/apt/sources.list

7.5 - Change "jessie" back to "buster"

7.6 - Press

"ctrl+x" > "Y" > "Enter"

8 - Update and Upgrade RPi

sudo apt-get update && sudo apt-get upgrade -y

9 - Compiling and Installing libsodium

9.1 - Download the libsodium, uncompress it, and cd into the uncompressed directory

wget https://github.com/jedisct1/libsodium/releases/download/1.0.3/libsodium-1.0.3.tar.gz && tar -zxvf libsodium-1.0.3.tar.gz && rm libsodium-1.0.3.tar.gz && sudo chmod -R a+rwx ./libsodium-1.0.3 && cd libsodium-1.0.3/ 

9.2 - Then, configure the system for compiling, do the actual compile job with make (will take a good while), and then install libsodium

./configure && make && sudo make install 

9.3 Exit folder

cd

10 - Compiling and Installing ZeroMQ latest versions

10.1 - Download the ZeroMQ, uncompress it, and cd into the uncompressed directory

wget https://github.com/zeromq/libzmq/releases/download/v4.3.2/zeromq-4.3.2.tar.gz && tar -zxvf zeromq-4.3.2.tar.gz && rm zeromq-4.3.2.tar.gz && sudo chmod -R a+rwx zeromq-4.3.2/ && cd zeromq-4.3.2/

10.2 - Then, configure the system for compiling, do the actual compile job with make (will take a good while), and then install ZeroMQ

./configure && make && sudo make install && sudo ldconfig 

11 - Compiling and Installing Berkeley DB 4.8

11.1 - Download the Berkeley DB, uncompress it, and cd into the uncompressed directory 

wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz && tar -xzvf db-4.8.30.NC.tar.gz && rm db-4.8.30.NC.tar.gz && sudo chmod -R a+rwx ./db-4.8.30 && sed -i 's/__atomic_compare_exchange/__atomic_compare_exchange_db/g' db-4.8.30.NC/dbinc/atomic.h && cd db-4.8.30.NC/build_unix/

11.2 - Then, configure the system for compiling, do the actual compile job with make (will take a good while), and then install Berkeley DB

sudo ../dist/configure --enable-cxx && make && sudo make install

12 - Compiling and Installing BitCanna Wallet

12.1 - clone the BitCanna GitHub, uncompress it, and cd into the directory

git clone https://github.com/BitCannaGlobal/BCNA.git && sudo chmod -R a+rwx ./BCNA && cd BCNA/

12.2 - open and edit the following file 

sudo nano /home/pi/BCNA/src/net.h

12.3 - add #include <atomic> at the end of the 1st include group

12.4 - press

"ctrl+x" > "Y" > "Enter"

12.5 - Then, configure the system for compiling, do the actual compile job with make (will take a good while), and then install the BitCanna Wallet

./autogen.sh && ./configure LIBS="-lboost_atomic" CXXFLAGS="--param ggc-min-expand=1 --param ggc-min-heapsize=32768" CPPFLAGS="-I/usr/local/BerkeleyDB.4.8/include -O2" LDFLAGS="-L/usr/local/BerkeleyDB.4.8/lib" --disable-tests --with-miniupnpc --enable-upnp-default && make -j2 && sudo make install


