![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/qjUSrrd.png)  
# BitCanna Raspberry Pi Wallet Installation Guides
# BitCanna Full Node Wallet Installation Guide on Raspberry Pi

*   [Welcome](#welcome "Welcome")
*   [Reminder](#reminder "Reminder")
*   [Installation](#installation "Installation")
    *   [Install RPi OS](#install-rpi-os "Install RPi OS")
    *   [Installation of the Full Node Wallet on Raspberry Pi](#installation-of-the-full-node-wallet-on-raspberry-pi "Installation of the Full Node Wallet on Raspberry Pi")
        *   [Building the RPi Kernel](#building-the-rpi-kernel "Building the RPi Kernel")
        *   [Install Boost Libraries ver.1.57](#install-boost-libraries-ver157 "Install Boost Libraries ver.1.57")
        *   [Install Required Dependencies](#install-required-dependencies "Install Required Dependencies")
        *   [Install a working libssl](#install-a-working-libssl "Install a working libssl")
        *   [Compile and Install libsodium](#compile-and-install-libsodium "Compile and Install libsodium")
        *   [Compile and Install ZeroMQ](#compile-and-install-zeromq "Compile and Install ZeroMQ")
        *   [Compile and Install Berkeley DB 4.8](#compile-and-install-berkeley-db-48 "Compile and Install Berkeley DB 4.8")
        *   [Install the missing Boost Libraries packages](#install-the-missing-boost-libraries-packages "Install the missing Boost Libraries packages")
        *   [Compile and Install the BitCanna Full Node Wallet](#compile-and-install-the-bitcanna-full-node-wallet "WelCompile and Install the BitCanna Full Node Walletcome")
        *   [Setting up the BitCanna Wallet for the 1st time](#setting-up-the-bitcanna-wallet-for-the-1st-time "Setting up the BitCanna Wallet for the 1st time")
        *   [Run the BitCanna Full Node Wallet on RPi](#run-the-bitcanna-full-node-wallet-on-rpi "Run the BitCanna Full Node Wallet on RPi")
*   [Running the BitCanna Full Node Wallet on the RPi](#running-the-bitcanna-full-node-wallet-on-the-rpi "Running the BitCanna Full Node Wallet on the RPi")
*   [Disclosure](#disclosure "Disclosure")
*   [Buy BCNA](#buy-bcna "Buy BCNA")
*   [Feedback](#feedback "Feedback")
*   [Support and Donating](#support-and-donating "Support and Donating")

 ## Welcome
 
Welcome to the Community Guide on how to install and run a BitCanna Full Node Wallet on a Raspberry Pi.
 
 ## Reminder
  
The following Guide follow a strict order of steps, commands and files editions that must be followed to have a successful result in compiling and installing the BitCanna Full Node Wallet on a Raspberry Pi OS environment.

 ## Installation
 
 ## Install RPi OS

This guide takes in consideration that you already have a Raspberry Pi (RPi) already with its OS installed, if not then use the official guides to do it.

https://projects.raspberrypi.org/en/projects/raspberry-pi-getting-started

Just make sure that you SKIP THE UPDATE and select RESTART LATER when prompted.	

 ## Installation of the Full Node Wallet on Raspberry Pi
 
After the initial setup of your RPi you will need to tweak it a little bit by following the steps:

- Access Raspberry Pi Software Configuration Tool

        sudo raspi-config

 - Change System Locales
     - Go to Localisation Options
     - Select Change Locale
     - Select the option en_US.UTF-8 UTF-8 and confirm with OK
     - Select the option en_US.UTF-8 and confirm with OK

(You can go back to the and configure the other remaining options to your needs if you want.)

 - Activate the SSH and VNC (if you want to use any of them) under the Interfacing Options menu 
 - Go to Advanced Options
     - Select the 1st option Expand Filesystem
(In case you used the NOOBS installation this option won’t appear due to already have been automatically done upon the installation of the OS)

 - Update the raspi-config tool
 - Exit raspi-config by selecting Finish

Now it is time to increase the swap size of the RPi. 

 - Edit the swapfile with

        sudo nano /etc/dphys-swapfile

     - Locate the line (in white) that says CONF_SWAPSIZE=100
     - Change the 100 value to 2048 to look like this 

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/YiYsOUe.jpg)
 
     - Exit the file with ctrl+x  
     - Confirm the changes saving with Y
     - And confirm with Enter

 - Enable the new swap size with (it will also change the permissions on the entire pi folder) and reboot de RPi

        sudo dphys-swapfile setup && sudo dphys-swapfile swapon && sudo chmod -R a+rwx ./ && sudo reboot now
        
 ## Building the RPi Kernel

To continue you will need to manually compile, install, and upgrade the RPi Kernel to its latest version.

The next steps will follow the official guides from raspberrypi.org (https://www.raspberrypi.org/documentation/linux/kernel/), I just chained a few of the commands together.

 - Building the Kernel
     - Start by installing git and some dependencies

        sudo apt-get install git bc bison flex libssl-dev make -y

     - Clone the Kernel github repository

        git clone --depth=1 https://github.com/raspberrypi/linux && sudo chmod -R a+rwx linux/

     - Configure the Kernel for building

        cd linux && KERNEL=kernel7 && make bcm2709_defconfig

     - Build the Kernel

        make -j4 zImage modules dtbs && sudo make modules_install && sudo cp arch/arm/boot/dts/*.dtb /boot/ && sudo cp arch/arm/boot/dts/overlays/*.dtb* /boot/overlays/ && sudo cp arch/arm/boot/dts/overlays/README /boot/overlays/ && sudo cp arch/arm/boot/zImage /boot/$KERNEL.img

(note: even with the -j 4 input the Kernel Building is a process that will take a while to complete, about 2h, so get something else to do while the RPi does it job)

     - Once it is finished exit the folder with:

        cd

 - Install “some” dependencies:

        sudo apt-get install apt apt-utils arandr base-files bind9-host bluetooth bluez bluez-firmware ca-certificates chromium-common chromium-sandbox curl dbus dbus-user-session dbus-x11 distro-info-data dphys-swapfile exim4-base exim4-config exim4-daemon-light ffmpeg firmware-amd-graphics firmware-atheros firmware-bnx2 firmware-bnx2x firmware-brcm80211 firmware-cavium firmware-intel-sound firmware-intelwimax firmware-ipw2x00 firmware-ivtv firmware-iwlwifi firmware-libertas firmware-linux firmware-linux-nonfree firmware-misc-nonfree firmware-myricom firmware-netronome firmware-netxen firmware-qcom-media firmware-qlogic firmware-realtek firmware-samsung firmware-siano firmware-ti-connectivity fuse gir1.2-pango-1.0 git git-man glib-networking glib-networking-common glib-networking-services grub-common grub2-common gtk2-engines-clearlookspix iputils-ping libapt-inst2.0 libapt-pkg5.0 libavcodec58 libavdevice58 libavfilter7 libavformat58 libavresample4 libavutil56 libbind9-161 libbluetooth3 libcups2 libcupsimage2 libcurl3-gnutls libcurl4 libdbus-1-3 libdns-export1104 libdns1104 libexif12 libfm-data libfm-extra4 libfm-gtk-data libfm-gtk4 libfm-modules libfm4 libfuse2 libgnutls-dane0 libgnutls30 libicu63 libinput-bin libinput10 libisc-export1100 libisc1100 libisccc161 libisccfg163 libjavascriptcoregtk-4.0-18 libjson-c3 libldap-2.4-2 libldap-common liblirc-client0 liblwres161 libmailutils5 libmariadb3 libnss-myhostname libnss3 libntlm0 libobrender32v5 libobt2v5 libopenmpt-modplug1 libopenmpt0 libpam-chksshpwd libpam-modules libpam-modules-bin libpam-runtime libpam-systemd libpam0g libpango-1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 libpangoxft-1.0-0 libperl5.28 libpostproc55 libpython3.7 libpython3.7-dev libpython3.7-minimal libpython3.7-stdlib libssh-gcrypt-4 libssl1.1 libswresample3 libswscale5 libsystemd0 libtag1v5 libtag1v5-vanilla libudev1 libunbound8 libunwind8 libvlc-bin libvlc5 libvlccore9 libwebkit2gtk-4.0-37 linux-libc-dev lxinput lxpanel lxpanel-data lxplug-bluetooth lxplug-cputemp lxplug-ejecter lxplug-network lxplug-ptbatt lxplug-volume lxterminal mailutils mailutils-common mariadb-common nfs-common obconf openbox openssl pcmanfm perl perl-base perl-modules-5.28 pi-greeter pi-package pi-package-data pi-package-session piclone pipanel piserver pishutdown piwiz pprompt python3-pgzero python3.7 python3.7-dev python3.7-minimal python3.7-venv qemu-user-static raspberrypi-sys-mods raspberrypi-ui-mods rc-gui rp-prefapps rpd-plym-splash rpi-chromium-mods rpi-update rpiboot systemd systemd-sysv tzdata udev vlc vlc-bin vlc-data vlc-l10n vlc-plugin-base vlc-plugin-notify vlc-plugin-qt vlc-plugin-samba vlc-plugin-skins2 vlc-plugin-video-output vlc-plugin-video-splitter vlc-plugin-visualization wpasupplicant xserver-common xserver-xorg-core -y

 - Update, Upgrade and Reboot the RPi

        sudo apt-get update && sudo apt-get full-upgrade -y && sudo apt-get clean && sudo reboot now

Now wait for the update and upgrade processes to finish and you will have your RPi all ready to start the installations process of all the required programs to compile and install the BitCanna Wallet on your RPi.

 ## Note
 
From now on in the chain of commands that downloads any files it will also include the commands that remove the downloaded file after being extracted and change the permissions of the extracted folder and all its content, which is something that will be done on all the downloadable files of the various software’s that will be installed along this guide so I won’t describe them all the time.
 
 ## Install Boost Libraries ver.1.57
 
To begin we will start to install the Boost Libraries ver.1.57
  https://www.boost.org/users/history/version_1_57_0.html
  
 - Download the Boost Libraries from the sourceforge download page, uncompress it, and enter the uncompressed folder with:
 
        wget https://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.gz && tar -xzvf boost_1_57_0.tar.gz && rm boost_1_57_0.tar.gz && sudo chmod -R a+rwx boost_1_57_0/ && cd boost_1_57_0/
        
 - After that configure the system for the compiling process, compile it and install it with:
 
        sudo ./bootstrap.sh && sudo ./b2 install
 
 - If the installation ended up like the image below you are good to continue, if not retrace your steps and check if you did not miss anything.
 
    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/JS3zRHJ.jpg)
 
 - Once it is finished exit the folder with:

        cd
 
 ## Install Required Dependencies
 
Now it is time to install some of the dependencies that we will need to install the remaining software.

 - Install the dependencies with:

        sudo apt-get install build-essential autoconf automake libtool libbz2-dev libssl-dev qt4-qmake libqt4-dev libminiupnpc-dev libdb++-dev libdb-dev libcrypto++-dev ufw git software-properties-common autotools-dev pkg-config libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev automake g++-mingw-w64-x86-64 libevent-dev libgmp-dev devscripts libsodium-dev qt5-default -y
 
 ## Install a working libssl
 
To continue we will need to remove the currently installed libssl and force install a specific version from the old Raspian OS versions

 - Start by removing the current libssl version and edit the sources file with:

        sudo apt-get remove libssl-dev -y && sudo nano /etc/apt/sources.list

   - Change the distribution version from "buster" to "jessie"
   - Exit the file with ctrl+x  
   - Confirm the changes saving with Y
   - And confirm with Enter
   
 - Also edit the raspi-list file with:

        sudo nano /etc/apt/sources.list.d/raspi.list

   - Change the distribution version from "buster" to "jessie"
   - Exit the file with ctrl+x  
   - Confirm the changes saving with Y
   - And confirm with Enter

 - Update and Install libssl-dev, mark and hold it, and edit RPi sources file again with:

        sudo apt-get update && sudo apt-get install -y libssl-dev && sudo apt-mark hold libssl-dev && sudo apt-mark hold libssl1.0.0 && sudo nano /etc/apt/sources.list

   - A Change the distribution version from "jessie" to "stretch"
   - Exit the file with ctrl+x  
   - Confirm the changes saving with Y
   - And confirm with Enter 
   
- Edit the raspi-list file again with:

        sudo nano /etc/apt/sources.list.d/raspi.list

   - A Change the distribution version from "jessie" to "stretch"
   - Exit the file with ctrl+x  
   - Confirm the changes saving with Y
   - And confirm with Enter 

 - Update and Upgrade RPi VM with:

        sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get clean
 
 ## Compile and Install libsodium
 
 - Download libsodium, uncompress it, and enter the uncompressed folder with:

        wget https://github.com/jedisct1/libsodium/releases/download/1.0.3/libsodium-1.0.3.tar.gz && tar -zxvf libsodium-1.0.3.tar.gz && rm libsodium-1.0.3.tar.gz && sudo chmod -R a+rwx libsodium-1.0.3/ && cd libsodium-1.0.3/

 - Configure the system for the compiling process, run the compiler, and then install libsodium with:

        ./configure && make -j4 && sudo make install

 - Once it is finished exit the folder with:

        cd 
 
 ## Compile and Install ZeroMQ
 
 - Download ZeroMQ, uncompress it, and enter the uncompressed folder with:

        wget https://github.com/zeromq/libzmq/releases/download/v4.3.2/zeromq-4.3.2.tar.gz && tar -zxvf zeromq-4.3.2.tar.gz && rm zeromq-4.3.2.tar.gz && sudo chmod -R a+rwx zeromq-4.3.2/ && cd zeromq-4.3.2/

 - Configure the system for the compiling process, run the compiler, and then install ZeroMQ with:

        ./configure && make -j4 && sudo make install && sudo ldconfig

 - Once it is finished exit the folder with:

        cd 

 ## Compile and Install Berkeley DB 4.8
 
 - Download Berkeley DB 4.8, uncompress it, and enter the uncompressed folder with:

        wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz && tar -xzvf db-4.8.30.NC.tar.gz && rm db-4.8.30.NC.tar.gz && sudo chmod -R a+rwx db-4.8.30.NC/ && sed -i 's/__atomic_compare_exchange/__atomic_compare_exchange_db/g' db-4.8.30.NC/dbinc/atomic.h && cd db-4.8.30.NC/build_unix/

 - Configure the system for the compiling process, run the compiler, and then install Berkeley DB 4.8 with:

        sudo ../dist/configure --enable-cxx && make -j4 && sudo make install

 - Once it is finished exit the folder with:

        cd 

 ## Install the missing Boost Libraries packages
 
 Run the Boost Libraries installation again to install the packages that were skipped and missed from the initial installation.

 - Run the following chain of commands:

        cd boost_1_57_0/ && sudo ./bootstrap.sh && sudo ./b2 install

If you remember you had previously ended the installation with a final message saying:

   ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/JS3zRHJ.jpg)

Which makes 8 target that were not initially updated, and if you now received a message like following one, means that the previous 8 missing targets have now been successfully updated:

   ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/b3v2sZ9.jpg)

 - Once it is finished exit the folder with:

        cd
 
 ## Compile and Install the BitCanna Full Node Wallet
 
Now comes the fun part where you will do the magic trick of compiling and installing the latest version of the BitCanna Full Node Wallet on your RPi VM

 - Start by cloning the BitCanna GitHub repository, change the downloaded folder and files permissions and enter it with:

        git clone https://github.com/BitCannaGlobal/BCNA.git && sudo chmod -R a+rwx BCNA/ && cd BCNA/

 - Open and edit the following file with:

        sudo nano /home/pi/BCNA/src/net.h

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/j7EeBRi.jpg)

   - Add #include <atomic> at the end of the 1st include group 
  
    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/c3A4He5.jpg)

   - Exit the file with ctrl+x  
   - Confirm the changes saving with Y
   - And confirm with Enter 

 - Configure the system for the compiling process, run the compiler, and then install the BitCanna Full Node Wallet with:

        ./autogen.sh && ./configure CXXFLAGS="--param ggc-min-expand=1 --param ggc-min-heapsize=32768" CPPFLAGS="-I/usr/local/BerkeleyDB.4.8/include -O2" LDFLAGS="-L/usr/local/BerkeleyDB.4.8/lib" --disable-tests --with-miniupnpc --enable-upnp-default && make -j4 && sudo make install

                    (this will take a while to complete even with the -j4 input so feel free to roll one (or more) and enjoy it/them)

 - Once it is finished exit the folder with:

        cd

 ## Setting up the BitCanna Wallet for the 1st time
 
 Now that you have successfully installed the BitCanna Wallet on your RPi VM it’s time to start it up, but before that lets make a few preparations upfront, before you fully run it.

 - Start by changing the permissions of the following folders and their content:

        sudo chmod -R a+rwx /usr/local/bin/ && sudo mkdir /home/pi/.bitcanna && sudo chmod -R a+rwx /home/pi/.bitcanna/

 - Create the bitcanna.conf file with:

        sudo nano /home/pi/.bitcanna/bitcanna.conf

   - Copy and paste the following lines into it:

          rpcuser=bitcannarpc
          rpcpassword=
          listen=1
          server=1
          daemon=1
          txindex=1
          maxconnections=1000
          enablezeromint=0
          banscore=50
          staking=1

   - Exit the file with ctrl+x  
   - Confirm the changes saving with Y
   - And confirm with Enter 

 - Run the wallet for the 1st time to get the information needed for the rpcpassword= in the bitcann.conf file using the following chain of commands:

        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/BerkeleyDB.4.8/lib" && bitcannad

 - The Wallet will crash and give out a warning message with some information.

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/xfw6LBq.jpg)

 - Locate where it says the following:

        rpcpassword=SOME_WEIRD_LOOKING_PASSWORD_YOU_WILL_NEVER_NEED_TO_REMEMBER

 - Select and copy the given password information and edit the bitcanna.conf file again with:

        sudo nano /home/pi/.bitcanna/bitcanna.conf

   - Add the password to its respective field

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/vAP8stP.jpg)

   - Exit the file with ctrl+x  
   - Confirm the changes saving with Y
   - And confirm with Enter 

 - Download and "install" bootstrap to speed up initial synchronization of the wallet with:

        cd .bitcanna/ && wget https://github.com/BitCannaCommunity/Bootstrap/releases/download/v4/Bootstrap.18-08-2020.zip && unzip Bootstrap.18-08-2020.zip && rm Bootstrap.18-08-2020.zip && sudo chmod -R a+rwx /home/pi/.bitcanna/

 - Once it is finished exit the folder with:

        cd

 ## Run the BitCanna Full Node Wallet on RPi
 
 After the bootstrap finishes download you can now run your wallet and start its synchronization process.

Note that even with the bootstrap it may take a while for the wallet to fully sync with the chain and seems that running the initial synchronization using the CLI is faster that with the GUI environment.

I will leave the instructions for both, so it is entirely up to you to decide which to follow.

If you plan using the GUI of the BitCanna Full Node Wallet you will need to activate the GL Driver on the Raspberry Pi Software Configuration Tool

 - Access Raspberry Pi Software Configuration Tool

        sudo raspi-config

 - Go to Advanced Options

   - Select the GL Driver option
   - Select the last option GL (Full KMS) OpenGL desktop driver with full KMS
   - Accept and reboot the RPi 

 - After reboot to launch the GUI simply use the following command on a Terminal window.

        bitcanna-qt -dbcache=50

(To be sure that is running the synchronization from the bootstrap you will see a message on the synchronization bar saying Importing blocks from disk…) 

   ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/WFPvgE8.jpg)

 - For the CLI environment start it by using the following command on a Terminal window:

        bitcannad

(You should see a message saying BCNA server starting)

   ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/9wBPSdH.jpg)

   - Check the syncing process with the command:

          bitcanna-cli getinfo

Look for the blocks information part to see it synchronizing:

   ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/QG9cruJ.jpg)

   - If you want, you can create a loop routine of the getinfo command to see an “auto-update” of the synchronization process while in the CLI environment:

          while true; do bitcanna-cli getinfo; sleep 3; done

   ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/UuPH4PS.jpg)

 - Now simply wait for the synchronization process to finish.

 ## Running the BitCanna Full Node Wallet on the RPi
 
 - For the CLI Wallet mode simply use:

        bitcannad

 - For the GUI Wallet mode use:

        bitcanna-qt -dbcache=50
               
## Disclosure

Keep in mind that these guides are a community made project, and there for no member of the BitCanna Team, and/or the author, are responsible for any funds lost by its usage. 

If you plan to use this as a working PoS Wallet do not forget to follow all the recommended safety and backup precautions of setting up a PoS Crypto Wallet.

 ## Buy BCNA
 
If you need or want to buy BCNA you can do it using the links below:

 - CoinDeal Exchange -> https://coindeal.com/ref/AVQU
 - STEX Exchange -> https://coindeal.com/ref/AVQU
 - Directly with Credit Card -> https://www.bitcanna.io/buy-bitcanna-with-credit-card/

 ## Feedback

Any improvements or suggestions to be added feel free to do it either through here or by telegram using the link -> https://t.me/Johnny_X89
 
 ## Support and Donating
 
If you found these guides useful and you fell like it feel free to donate any tips to support and improve it:

 - BCNA -> BFJt7ETtucGmifwtmspf1LeJ75Cw6tG3YY
 - BTC -> bc1qv8xvnf7376sv3qnxemh0y6hjkz7vcsgzhr5aln 
