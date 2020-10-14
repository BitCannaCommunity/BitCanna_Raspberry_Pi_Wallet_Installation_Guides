![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/qjUSrrd.png)  
# BitCanna Raspberry Pi Wallet Installation Guides
# BitCanna Full Node Wallet Installation Guide on Raspberry Pi under a Virtual Machine

*   [Welcome](#welcome "Welcome")
*   [Reminder](#reminder "Reminder")
*   [Installation](#installation "Installation")
    *   [Install Oracle VM VirtualBox and create and setup a Virtual Machine](#install-oracle-vm-virtualbox-and-create-and-setup-a-virtual-machine "Install Oracle VM VirtualBox and create and setup a Virtual Machine")
    *   [Install RPi OS on the Virtual Machine](#install-rpi-os-on-the-virtual-machine "Install RPi OS on the Virtual Machine")
    *   [Installation of the Full Node Wallet on Raspberry Pi under a Virtual Machine](#installation-of-the-full-node-wallet-on-raspberry-pi-under-a-virtual-machine "Installation of the Full Node Wallet on Raspberry Pi under a Virtual Machine")
        *   [Install Boost Libraries ver.1.57](#install-boost-libraries-ver157 "Install Boost Libraries ver.1.57")
        *   [Install Required Dependencies](#install-required-dependencies "Install Required Dependencies")
        *   [Install a working libssl](#install-a-working-libssl "Install a working libssl")
        *   [Compile and Install libsodium](#compile-and-install-libsodium "Compile and Install libsodium")
        *   [Compile and Install ZeroMQ](#compile-and-install-zeromq "Compile and Install ZeroMQ")
        *   [Compile and Install Berkeley DB 4.8](#compile-and-install-berkeley-db-48 "Compile and Install Berkeley DB 4.8")
        *   [Install the missing Boost Libraries packages](#install-the-missing-boost-libraries-packages "Install the missing Boost Libraries packages")
        *   [Compile and Install the BitCanna Full Node Wallet](#compile-and-install-the-bitcanna-full-node-wallet "WelCompile and Install the BitCanna Full Node Walletcome")
        *   [Setting up the BitCanna Wallet for the 1st time](#setting-up-the-bitcanna-wallet-for-the-1st-time "Setting up the BitCanna Wallet for the 1st time")
        *   [Run the BitCanna Full Node Wallet on RPi VM](#run-the-bitcanna-full-node-wallet-on-rpi-vm "Run the BitCanna Full Node Wallet on RPi VM")
*   [Running the BitCanna Full Node Wallet on the RPi VM](#running-the-bitcanna-full-node-wallet-on-the-rpi-vm "Running the BitCanna Full Node Wallet on the RPi VM")
*   [Disclosure](#disclosure "Disclosure")
*   [Buy BCNA](#buy-bcna "Buy BCNA")
*   [Feedback](#feedback "Feedback")
*   [Support and Donating](#support-and-donating "Support and Donating")

 ## Welcome
 
Welcome to the Community Guide on how to install and run a BitCanna Full Node Wallet on a Raspberry Pi using a Virtual Machine.
 
 ## Reminder
  
The following Guide follow a strict order of steps, commands and files editions that must be followed to have a successful result in compiling and installing the BitCanna Full Node Wallet on a Raspberry Pi OS environment using a Virtual Machine.

 ## Installation
 ## Install Oracle VM VirtualBox and create and setup a Virtual Machine
 
To begin you will need to have a Virtual Machine (VM) setup with the Raspberry Pi (RPi) OS.

If you do not know how to do it follow the steps below:

 - Download and Install the Oracle VM VirtualBox using the official installation files, as well as the Extension Pack:
     - https://www.oracle.com/virtualization/technologies/vm/downloads/virtualbox-downloads.html
 - Download the RPi OS disc image
     - https://www.raspberrypi.org/downloads/raspberry-pi-desktop/
 - Open Oracle VM VirtualBox Manger
 - Click on New

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/DCyDZBN.jpg)

 - Give it a Name, for example RPi BitCanna Wallet
     - Select Linux as the OS Type
     - Select Debian (32-bit) as Version
     - Click Next

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/zkxQmMa.jpg)

 - Select Memory size (choose either 1024 or 2048, there isn’t any requirement for any of them) and click Next
 - Select the option Create a virtual hard disk now and click Create
 - Select the option VDI (VirtualBox Disk Image) and click Next
 - Select the option Fixed size and click Next
 - Select the disk size, I recommend at least 32GB, and click Create
      
        ## Wait for the creation process to finish (this can take a bit)
        
Now that you have your VM created let’s make a few adjustments to it before we boot it up

 - Left click over you newly created VM and select Settings
     - In the General menu go the Advanced tab
     - Change both Shared Clipboard and Drag’n’Drop to Bidirectional

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/jJmINE8.jpg)
    
     - In the System menu Enable I/O APIC on the Motherboard tab
     
    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/w0bM4Tg.jpg)
    
     - Add a second processor in the Processor tab
     
    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/xS32Jfy.jpg)
    
     - Turn on the Network Adapters 1 (where the Name of the adapter will be your PC in-built network adaptor) and 2 (where you turn on the VM network adapter)
     
    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/eqpHGVB.jpg)
    
    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/J68gXKq.jpg)
    
 - Now you are all set to start your VM and install the RPi OS.
 
 ## Install RPi OS on the Virtual Machine

 - Start your VM

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/cpqodAt.jpg)

 - Choose the previous downloaded RPi OS disk image file and then click Start

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/g5qIPyh.jpg)

 - Choose either Graphical install or Install 
(despite their names there are both remarkably similar looking, the major difference is the possibility to use the mouse on the Graphical install option).

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/aLLTNNQ.jpg)
(For the guide I went with the Graphical just to show it.)

 - Choose your keyboard language setup
 - When prompt about the Disk Partition select the option Guided – use entire disk and click Continue

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/wqNj5ev.jpg)

 - Select the Disk to Partition and click Continue
 - Select the type of Partition scheme, usually recommended the default option and click Continue

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/kDlJd75.jpg)

 - Confirm the disk writing option and then confirm to write to disk

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/HXQtlZ7.jpg)

 - When prompt about the GRUB installation select Yes and Continue

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/fCiWLDH.jpg)

 - Select the disk to install GRUB

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/75HulGL.jpg)

 - Wait for the OS Installation to finish and boot into your RPi
 - Once you are logged into your RPi do the initial setup (country, language and time zone), enter a password 
 - SKIP THE UPDATE and select RESTART LATER

Now we need to make the RPi VM a bit more user friendly in terms of usage by installing the Guest Additions

 - Go to the Devices menu and select the last option Insert Guest Additions CD image

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/0OZchg4.jpg)

 - Right-click on the VBox_GAs_6.1.12 and select Open in Terminal

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/MLi0TKF.jpg)

 - Login as root 

        sudo su

 - Install the Guest Additions 

        sh VBoxLinuxAdditions.run

Once it finishes installing you can resize the VM window and copy and paste between your PC and the VM environment.	

 ## Installation of the Full Node Wallet on Raspberry Pi under a Virtual Machine
 
After the initial setup of your RPi you will need to tweak it a little bit by following the steps:

- Access Raspberry Pi Software Configuration Tool

        sudo raspi-config

 - Change System Locales
     - Go to Localisation Options
     - Select Change Locale
     - Select the option en_US.UTF-8 UTF-8 and confirm with OK
     - Select the option en_US.UTF-8 and confirm with OK

(You can go back to the and configure the other remaining options to your needs if you want.)

 - Activate the SSH (if you want to use it) and Update the raspi-config
 - Exit raspi-config by selecting Finish

Now it’s time to increase the swap size of the RPi. 

 - Edit the swapfile with

        sudo nano /etc/dphys-swapfile

   - Locate the line (in white) that says CONF_SWAPSIZE=100
   - Change the 100 value to 2048 to look like this
   
    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/YiYsOUe.jpg)
   
   - Exit the file with ctrl+x  
   - Confirm the changes saving with Y
   - And confirm with Enter

 - Enable the new swap size with (it will also change the permissions on the entire pi folder)

        sudo dphys-swapfile setup && sudo dphys-swapfile swapon && sudo chmod -R a+rwx ./

 - Update and Upgrade the RPi VM

        sudo apt-get update && sudo apt-get full-upgrade -y && sudo apt-get clean && sudo reboot now

Now wait for the update and upgrade processes to finish and you will have your RPi VM all ready to start the installations process of all the required programs to compile and install the BitCanna Wallet on your RPi VM.

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

 - Update and Install libssl-dev, mark and hold it, and edit RPi sources file again with:

        sudo apt-get update && sudo apt-get install -y libssl-dev && sudo apt-mark hold libssl-dev && sudo apt-mark hold libssl1.0.0 && sudo nano /etc/apt/sources.list

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

(note: this will take a while to complete even with the -j4 input so feel free to roll one (or more) and enjoy it/them)

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

 - Run the wallet for the 1st time to get the information needed for the rpcpassword= in the bitcann.conf file

   - For the CLI Wallet mode use the following chain of commands:

        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/BerkeleyDB.4.8/lib" && bitcannad

   - For the GUI Wallet mode use the following chain of commands:

        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/BerkeleyDB.4.8/lib" && bitcanna-qt

 - The Wallet will crash and give out a warning message with some information.

   - CLI version

    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/xfw6LBq.jpg)

   - GUI version
   
    ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/Xa1dn2x.jpg)

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

        cd .bitcanna/ && wget https://github.com/BitCannaCommunity/Bootstrap/releases/download/v5/Bootstrap.05-10-2020.zip && unzip Bootstrap.05-10-2020.zip && rm Bootstrap.05-10-2020.zip && sudo chmod -R a+rwx /home/pi/.bitcanna/

 - Once it is finished exit the folder with:

        cd

 ## Run the BitCanna Full Node Wallet on RPi VM
 
 After the bootstrap finishes download you can now run your wallet and start its synchronization process.

Note that even with the bootstrap it may take a while for the wallet to fully sync with the chain and seems that running the initial synchronization using the CLI is faster that with the GUI environment.

I will leave the instructions for both, so it is entirely up to you to decide which to follow.

 - For the GUI environment synchronization simply use the following chain of commands and leave it running.

        bitcanna-qt -dbcache=50

(To be sure that is running the synchronization from the bootstrap you will see a message on the synchronization bar saying Importing blocks from disk…) 

   ![BitCannaRaspberryPiWalletInstallationGuides](https://i.imgur.com/WFPvgE8.jpg)

 - For the CLI environment synchronization start by using the following chain of commands to start the wallet:

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

 ## Running the BitCanna Full Node Wallet on the RPi VM
 
When running the wallet for the 1st time, either after starting the VM or rebooting it, or opening up a new terminal window/tab to start the wallet will require the use of the chain of command in order for the wallet to start:

 - For the CLI Wallet mode use the following chain of commands:

        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/BerkeleyDB.4.8/lib" && bitcannad

 - For the GUI Wallet mode use the following chain of commands:

        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/BerkeleyDB.4.8/lib" && bitcanna-qt -dbcache=50
               
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
