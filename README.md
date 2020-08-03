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

sudo ./bootstrap.sh && sudo ./b2 install

5.3 - Exit the folder

cd

6 - Install some dependencies

sudo apt-get install -y build-essential autoconf automake libtool libbz2-dev libssl-dev qt4-qmake libqt4-dev libminiupnpc-dev libdb++-dev libdb-dev libcrypto++-dev ufw git software-properties-common autotools-dev pkg-config libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev automake g++-mingw-w64-x86-64 libevent-dev libgmp-dev devscripts libsodium-dev qt5-default

(libasio-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libboost-atomic1.58* libboost-chrono1.58* libboost-context1.58* libboost-coroutine1.58* libboost-date-time1.58* libboost-exception1.58* libboost-filesystem1.58* libboost-graph-parallel1.58* libboost-graph1.58* libboost-iostreams1.58* libboost-locale1.58* libboost-log1.58* libboost-math1.58* libboost-mpi-python1.58* libboost-mpi1.58* libboost-program-options1.58* libboost-python1.58* libboost-random1.58* libboost-regex1.58* libboost-serialization1.58* libboost-signals1.58* libboost-system1.58* libboost-test1.58* libboost-thread1.58* libboost-timer1.58* libboost-wave1.58* libboost1.58*) - still not sure if needed or not and if next step is to skip 


7 - Install a working libssl (VM mode)

7.1 - Remove current libssl and edit RPi sources file

sudo apt-get remove libssl-dev && sudo nano /etc/apt/sources.list

7.2 - Change "buster" to "jessie" 

7.3 - Press

"ctrl+x" > "Y" > "Enter"

7.4 - Update and Install libssl-dev, mark and hold it, and edit RPi sources file again 

sudo apt-get update && sudo apt-get install -y libssl-dev && sudo apt-mark hold libssl-dev && sudo apt-mark hold libssl1.0.0 && sudo nano /etc/apt/sources.list

7.5 - Change "jessie" back to "buster"

7.6 - Press

"ctrl+x" > "Y" > "Enter"

7 - Install a working libssl (RPi mode)

sudo apt-get install libssl1.0-dev -y

8 - Update and Upgrade RPi

sudo apt-get update && sudo apt-get upgrade -y

9 - Compiling and Installing libsodium

9.1 - Download the libsodium, uncompress it, and cd into the uncompressed directory

wget https://github.com/jedisct1/libsodium/releases/download/1.0.3/libsodium-1.0.3.tar.gz && tar -zxvf libsodium-1.0.3.tar.gz && rm libsodium-1.0.3.tar.gz && sudo chmod -R a+rwx libsodium-1.0.3/ && cd libsodium-1.0.3/ 

9.2 - Then, configure the system for compiling, do the actual compile job with make (will take a good while), and then install libsodium

./configure && make -j2 && sudo make install 

9.3 Exit folder

cd

10 - Compiling and Installing ZeroMQ latest versions

10.1 - Download the ZeroMQ, uncompress it, and cd into the uncompressed directory

wget https://github.com/zeromq/libzmq/releases/download/v4.3.2/zeromq-4.3.2.tar.gz && tar -zxvf zeromq-4.3.2.tar.gz && rm zeromq-4.3.2.tar.gz && sudo chmod -R a+rwx zeromq-4.3.2/ && cd zeromq-4.3.2/ 

10.2 - Then, configure the system for compiling, do the actual compile job with make (will take a good while), and then install ZeroMQ

./configure && make -j2 && sudo make install && sudo ldconfig 

10.3 - Exit folder 

cd

11 - Compiling and Installing Berkeley DB 4.8

11.1 - Download the Berkeley DB, uncompress it, and cd into the uncompressed directory 

wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz && tar -xzvf db-4.8.30.NC.tar.gz && rm db-4.8.30.NC.tar.gz && sudo chmod -R a+rwx db-4.8.30.NC/ && sed -i 's/__atomic_compare_exchange/__atomic_compare_exchange_db/g' db-4.8.30.NC/dbinc/atomic.h && cd db-4.8.30.NC/build_unix/

11.2 - Then, configure the system for compiling, do the actual compile job with make (will take a good while), and then install Berkeley DB

sudo ../dist/configure --enable-cxx && make -j2 && sudo make install

11.3 - Exit folder

cd

12 - Compiling and Installing the BitCanna Wallet

12.1 - clone the BitCanna GitHub, uncompress it, and cd into the directory

git clone https://github.com/BitCannaGlobal/BCNA.git && sudo chmod -R a+rwx BCNA/ && cd BCNA/

12.2 - open and edit the following file 

sudo nano /home/pi/BCNA/src/net.h

12.3 - add #include <atomic> at the end of the 1st include group

12.4 - press

"ctrl+x" > "Y" > "Enter"

12.5 - Then, configure the system for compiling, do the actual compile job with make (will take a good while), and then install the BitCanna Wallet

cd BCNA/ && ./autogen.sh && ./configure LIBS="-lboost_atomic" CXXFLAGS="--param ggc-min-expand=1 --param ggc-min-heapsize=32768" CPPFLAGS="-I/usr/local/BerkeleyDB.4.8/include -O2" LDFLAGS="-L/usr/local/BerkeleyDB.4.8/lib" --disable-tests --with-miniupnpc --enable-upnp-default && make -j2 && sudo make install

12.6 - Exit folder

cd

13 - Change permitions of the folders:

sudo chmod -R a+rwx /usr/local/bin/ && sudo mkdir /home/pi/.bitcanna && sudo chmod -R a+rwx /home/pi/.bitcanna/

14 - Create bitcanna.conf

sudo nano /home/pi/.bitcanna/bitcanna.conf

14.1 - Copy and past the code lines below

rpcuser=bitcannarpc
rpcpassword=
listen=1
server=1
daemon=1
txindex=1
maxconnections=1000
staking=0
enablezeromint=0
banscore=50
addnode=209.250.255.175:12888
addnode=108.61.165.138:12888
addnode=185.92.223.251:12888
addnode=37.97.227.83:12907
addnode=37.97.227.83:12888
addnode=80.240.25.195:12888
addnode=37.97.227.83:12905
addnode=95.179.142.124:12888
addnode=45.77.138.90:12888
addnode=95.179.183.115:12888
addnode=209.250.254.30:12888
addnode=37.97.227.83:12889
addnode=89.29.176.219:12888
addnode=78.141.216.198:12888
addnode=37.97.227.83:12901
addnode=37.97.227.83:12890
addnode=37.97.227.83:12891
addnode=37.97.227.83:12902
addnode=37.97.227.83:12903
addnode=37.97.227.83:12893
addnode=37.97.227.83:12894
addnode=167.71.0.53:12888
addnode=37.97.227.83:12895
addnode=37.97.227.83:12896
addnode=37.97.227.83:12897
addnode=37.97.227.83:12906
addnode=37.97.227.83:12898
addnode=62.171.190.198:1288
addnode=37.97.227.83:12900
addnode=164.68.103.60:12888
addnode=167.86.107.226:12888
addnode=167.86.107.228:12888
addnode=173.212.215.124:12888
addnode=116.203.206.254:12888
addnode=159.69.109.74:12888
addnode=49.12.43.129:12888
addnode=116.203.228.107:12888
addnode=78.47.67.67:12888
addnode=78.47.168.208:12888
addnode=164.68.105.190:12888
addnode=93.171.202.9:12888
addnode=94.225.220.3:12888
addnode=151.80.58.62:12888
addnode=173.212.227.191:12888

14.2 - press

"ctrl+x" > "Y" > "Enter"

14.3 - Run Wallet to get rpcpassword= info

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/BerkeleyDB.4.8/lib" && bitcanna-qt

14.4 - Will crash with a warning message

14.5 - Locate where says rpcpassword=SOME_WEIRD_PASSWORD

14.6 - Select and copy it with mouse

14.7 - Edit Create bitcanna.conf

sudo nano /home/pi/.bitcanna/bitcanna.conf

14.8 - Add the copied password to rpcpassword=

14.9 - press

"ctrl+x" > "Y" > "Enter"

15 - Download and "install" bootstrap to speed up initial syncronization of the wallet

cd .bitcanna/ && wget https://github.com/BitCannaCommunity/Bootstrap/releases/download/v3/Bootstrap.09-06-2020.zip && unzip -xzvf Bootstrap.09-06-2020.zip && rm Bootstrap.09-06-2020.zip && && sudo chmod -R a+rwx /home/pi/.bitcanna/

16 - Run and sync Wallet 1st time - I recomend doing the 1st initial sync (wit or without the bootstrap) using the CLI mode for a faster syncing process

16.1 - Run wallet in its headless mode

bitcannad

16.2 - Check sync process using command

bitcanna-cli getinfo

Not necessary but can be handy
16.3 - Create routine for autoupdate on sync process

while true; do bitcanna-cli getinfo; sleep 3; done

17 - Wait for sync to finish 

18 - Once Sync is finish use wallet as normal by using the syntax

bitcanna-cli WALLET_COMMAND

19 - For Using the QT GUI Wallet

19.1 - Stop the current wallet

kill all bitcannad

19.2 - Run Wallet with QT GUI

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/BerkeleyDB.4.8/lib" && bitcanna-qt

