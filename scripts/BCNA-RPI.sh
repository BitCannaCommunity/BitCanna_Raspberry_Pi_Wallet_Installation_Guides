#!/bin/bash
#----------------------------------------------------------#
#        A BitCanna Community Installation Script          #
#                        NO OFFICIAL                       #   
#----------------------------------------------------------#
#----------------------------------------------------------#
#                      Version: V1.00                      #
#                 Donate BitCanna Address:                 #
# --> hellresistor: B73RRFVtndfPRNSgSQg34yqz4e9eWyKRSv <-- #
# --> Johnny_X89:   BFJt7ETtucGmifwtmspf1LeJ75Cw6tG3YY <-- #
#                                                          #
#                      Source Guide:                       #
# https://github.com/BitCannaCommunity/BitCanna_Raspberry_ #
# Pi_Wallet_Installation_Guides/blob/master/RPI_GUIDE.md   #
#----------------------------------------------------------#
colors(){
# Rainbow on our lives
export endc=$'\e[0m'
export sbl=$'\e[4m'
export bld=$'\e[1m'
export blk=$'\e[5m'
export deflt=${bld}$'\e[97m'
export bkwhite=${endc}$'\e[48;5;235m'${deflt}
export red=${bkwhite}$'\e[38;5;196m'
export green=${bkwhite}$'\e[38;5;34m'
export yellow=${bkwhite}$'\e[38;5;172m'
export grey=${bkwhite}$'\e[1;38;5;252m'
}
varys(){
# System variables
RPIGUIDE="NO"
DATENOW=$(date +"%Y%m%d%H%M%S")
RPISTEPS="0"
readonly temp_counter="30"
readonly BCNAREP="https://github.com/BitCannaGlobal/BCNA.git"
readonly GETLASTBOOT=$(curl --silent "https://api.github.com/repos/BitCannaCommunity/Bootstrap/releases/latest" | grep -Po '"name": "\K.*?(?=.zip)')
readonly BCNABOOT=$(curl --silent "https://api.github.com/repos/BitCannaCommunity/Bootstrap/releases/latest" | grep 'browser_' | cut -d\" -f4)
readonly BCNAPKG="BCNA"
readonly BCNAHOME="$HOME"
readonly BCNACONF=".bitcanna"
readonly BCNADIR="$BCNAPKG"
readonly BCNAPORT="12888"
readonly BCNACLI="bitcanna-cli"
readonly BCNAD="bitcannad"
readonly VPSIP="$(curl -s ifconfig.me)"
readonly SCRPTVER="V1.00"
readonly DONATE="B73RRFVtndfPRNSgSQg34yqz4e9eWyKRSv"
readonly DONATE2="BFJt7ETtucGmifwtmspf1LeJ75Cw6tG3YY"
}
intro(){
echo -e "${bkwhite}\n${green}  bbc                              Script Contribution to BitCanna Community\n${green}  bbb                                     to RaspberryPi B+ ARM64\n${green}  bbbbb                            ${grey}-------------------------------------------\n${green}  bbbbb                              ${bkwhite}Executing this script you are Allow to${grey}:\n${green}  bbbbb   cbcb          bbbbbb \n${green}  bbbbb bbbbbbbbb     bbbbbbbbbb     ${grey}- ${bkwhite}Install ${bkwhite}/ ${bkwhite}Update ${bkwhite}/ ${bkwhite}Remove BCNA Wallet\n${green}  bbbcb bbbbbbbbbb   cbbbbbbcbbbb    ${grey}- ${bkwhite}Configure Full Node ${grey}(${bkwhite}Proof-Of-Stake${grey})\n${green}  bbbbbbbb    bbbbbibbbb      cbbb \n${green}  bbbbib        bbb bibbb  \n${green}  bbbbib         bbbbbb             ${grey}------------------------------------------\n${green}  bbbbbb         bbbbbb  \n${green}  bbcbbb         bbbbcb                       ${bkwhite}Project Ver${grey}: ${bld}${yellow}$SCRPTVER${green}\n${green}  bbbbbb         bbbbbcb \n${green}  bbbbbbbb      bbbbbbbbbc     cbbb              ${bkwhite}by hellresistor \n${green}    bbbbbbbbbbbbbcbb bbbbbbbbbbbbb   ${bkwhite}Support donate seeds/CBD with Bitcanna\n${green}     bbbbbbbbbbb bbb cbbbbbbbbbib \n${green}       bbbbbbbbb       bbbbibbbb    ${bkwhite}Johnny_X89${grey}: ${yellow}${bld}${sbl}$DONATE2${bkwhite}\n${green}        bbbbbbb         bbbibbb   ${bkwhite}hellresistor${grey}: ${yellow}${bld}${sbl}$DONATE${bkwhite}\n\n\n${bld}${sbl}${red}    HAVE IN MIND!! EVERY TIME DO YOUR OWN BACKUPS BEFORE USING THIS SCRIPT\n${bld}${sbl}${red}           I have NO responsability about system/wallet corruption!\n${bld}${sbl}${yellow}                       Use this Script at your own risk!${bkwhite}\n\n"
}
preraspberry(){
if [ "$RPIGUIDE" != "OK" ]; then
 echo "You NOT HAVE DONE this STEP before running This Script !!!"
 echo "https://github.com/BitCannaCommunity/BitCanna_Raspberry_Pi_Wallet_Installation_Guides/blob/master/RPI_GUIDE.md#installation-of-the-full-node-wallet-on-raspberry-pi"
 echo && echo "When FINISH that step, CHANGE variable -> RPIGUIDE=\"OK\" on this Script"
 read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${bkwhite}")"
 exit 0
fi
if [ "$RPISTEPS" -eq "0" ]; then
 echo -e "${grey}--> ${green}Building the RPi Kernel ${grey}... ${yellow}420 Time \n${bkwhite}"
 sudo apt-get install git bc bison flex libssl-dev make -y
 git clone --depth=1 https://github.com/raspberrypi/linux && sudo chmod -R a+rwx linux/
 cd linux && KERNEL=kernel7 && make bcm2709_defconfig
 make -j4 zImage modules dtbs && sudo make modules_install && sudo cp arch/arm/boot/dts/*.dtb /boot/ && sudo cp arch/arm/boot/dts/overlays/*.dtb* /boot/overlays/ && sudo cp arch/arm/boot/dts/overlays/README /boot/overlays/ && sudo cp arch/arm/boot/zImage /boot/$KERNEL.img
 cd || exit
 sudo apt-get install apt apt-utils arandr base-files bind9-host bluetooth bluez bluez-firmware ca-certificates chromium-common chromium-sandbox curl dbus dbus-user-session dbus-x11 distro-info-data dphys-swapfile exim4-base exim4-config exim4-daemon-light ffmpeg firmware-amd-graphics firmware-atheros firmware-bnx2 firmware-bnx2x firmware-brcm80211 firmware-cavium firmware-intel-sound firmware-intelwimax firmware-ipw2x00 firmware-ivtv firmware-iwlwifi firmware-libertas firmware-linux firmware-linux-nonfree firmware-misc-nonfree firmware-myricom firmware-netronome firmware-netxen firmware-qcom-media firmware-qlogic firmware-realtek firmware-samsung firmware-siano firmware-ti-connectivity fuse gir1.2-pango-1.0 git git-man glib-networking glib-networking-common glib-networking-services grub-common grub2-common gtk2-engines-clearlookspix iputils-ping libapt-inst2.0 libapt-pkg5.0 libavcodec58 libavdevice58 libavfilter7 libavformat58 libavresample4 libavutil56 libbind9-161 libbluetooth3 libcups2 libcupsimage2 libcurl3-gnutls libcurl4 libdbus-1-3 libdns-export1104 libdns1104 libexif12 libfm-data libfm-extra4 libfm-gtk-data libfm-gtk4 libfm-modules libfm4 libfuse2 libgnutls-dane0 libgnutls30 libicu63 libinput-bin libinput10 libisc-export1100 libisc1100 libisccc161 libisccfg163 libjavascriptcoregtk-4.0-18 libjson-c3 libldap-2.4-2 libldap-common liblirc-client0 liblwres161 libmailutils5 libmariadb3 libnss-myhostname libnss3 libntlm0 libobrender32v5 libobt2v5 libopenmpt-modplug1 libopenmpt0 libpam-chksshpwd libpam-modules libpam-modules-bin libpam-runtime libpam-systemd libpam0g libpango-1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 libpangoxft-1.0-0 libperl5.28 libpostproc55 libpython3.7 libpython3.7-dev libpython3.7-minimal libpython3.7-stdlib libssh-gcrypt-4 libssl1.1 libswresample3 libswscale5 libsystemd0 libtag1v5 libtag1v5-vanilla libudev1 libunbound8 libunwind8 libvlc-bin libvlc5 libvlccore9 libwebkit2gtk-4.0-37 linux-libc-dev lxinput lxpanel lxpanel-data lxplug-bluetooth lxplug-cputemp lxplug-ejecter lxplug-network lxplug-ptbatt lxplug-volume lxterminal mailutils mailutils-common mariadb-common nfs-common obconf openbox openssl pcmanfm perl perl-base perl-modules-5.28 pi-greeter pi-package pi-package-data pi-package-session piclone pipanel piserver pishutdown piwiz pprompt python3-pgzero python3.7 python3.7-dev python3.7-minimal python3.7-venv qemu-user-static raspberrypi-sys-mods raspberrypi-ui-mods rc-gui rp-prefapps rpd-plym-splash rpi-chromium-mods rpi-update rpiboot systemd systemd-sysv tzdata udev vlc vlc-bin vlc-data vlc-l10n vlc-plugin-base vlc-plugin-notify vlc-plugin-qt vlc-plugin-samba vlc-plugin-skins2 vlc-plugin-video-output vlc-plugin-video-splitter vlc-plugin-visualization wpasupplicant xserver-common xserver-xorg-core -y
 sudo apt-get update && sudo apt-get full-upgrade -y && sudo apt-get clean
 sed -i 's/RPISTEPS="0"/RPISTEPS="1"/' BCNA-RPI.sh
 cat <<EOF >> "$BCNAHOME"/.bashrc
### RPIConfig ###
if [ -f BCNA-RPI.sh ]; then
 . BCNA-RPI.sh
fi
### RPIConfig ###
EOF
 sudo reboot now
elif [ "$RPISTEPS" -eq "1" ]; then
 sed -i '/RPIConfig/,/RPIConfig/d' "$BCNAHOME"/.bashrc
 sed -i 's/RPISTEPS="1"/RPISTEPS="2"/' BCNA-RPI.sh
 echo "Install Boost Libraries v.1.57"
 wget https://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.gz && tar -xzvf boost_1_57_0.tar.gz && rm boost_1_57_0.tar.gz && sudo chmod -R a+rwx boost_1_57_0/ && cd boost_1_57_0/ || exit
 sudo ./bootstrap.sh && sudo ./b2 install
 cd || exit
 echo "Install Dependencies packages.."
 sudo apt-get install build-essential autoconf automake libtool libbz2-dev libssl-dev qt4-qmake libqt4-dev libminiupnpc-dev libdb++-dev libdb-dev libcrypto++-dev ufw git software-properties-common autotools-dev pkg-config libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev automake g++-mingw-w64-x86-64 libevent-dev libgmp-dev devscripts libsodium-dev qt5-default -y
 sudo apt-get remove libssl-dev -y 
 sudo sed -i 'g/buster/jessie/' /etc/apt/sources.list
 sudo sed -i 'g/buster/jessie/' /etc/apt/sources.list.d/raspi.list
 sudo apt-get update && sudo apt-get install -y libssl-dev && sudo apt-mark hold libssl-dev && sudo apt-mark hold libssl1.0.0
 sudo sed -i 'g/jessie/stretch/' /etc/apt/sources.list
 sudo sed -i 'g/jessie/stretch/' /etc/apt/sources.list.d/raspi.list
 sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get clean
 echo "Install Libsodium ..."
 wget https://github.com/jedisct1/libsodium/releases/download/1.0.3/libsodium-1.0.3.tar.gz && tar -zxvf libsodium-1.0.3.tar.gz && rm libsodium-1.0.3.tar.gz && sudo chmod -R a+rwx libsodium-1.0.3/ && cd libsodium-1.0.3/ || exit
 ./configure && make -j4 && sudo make install
 cd || exit
 echo "Compile and Insall ZeroMQ ..."
 wget https://github.com/zeromq/libzmq/releases/download/v4.3.2/zeromq-4.3.2.tar.gz && tar -zxvf zeromq-4.3.2.tar.gz && rm zeromq-4.3.2.tar.gz && sudo chmod -R a+rwx zeromq-4.3.2/ && cd zeromq-4.3.2/ || exit
 ./configure && make -j4 && sudo make install && sudo ldconfig
 cd || exit
 echo "Compile and Install Berkeley DB 4.8"
 wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz && tar -xzvf db-4.8.30.NC.tar.gz && rm db-4.8.30.NC.tar.gz && sudo chmod -R a+rwx db-4.8.30.NC/ && sed -i 's/__atomic_compare_exchange/__atomic_compare_exchange_db/g' db-4.8.30.NC/dbinc/atomic.h && cd db-4.8.30.NC/build_unix/ || exit
 sudo ../dist/configure --enable-cxx && make -j4 && sudo make install
 cd || exit
 echo "Installing missing Boost Librarieds packages ... "
 cd boost_1_57_0/ && sudo ./bootstrap.sh && sudo ./b2 install
 cd || exit
elif [ "$RPISTEPS" -eq "2" ]; then
 echo "All Preparation to RPI DONE!" && sleep 1
else
 echo -e "${grey}--> ${red}SOME ERROR ${grey}!!!!\n${red}Exiting${grey}...${endc}" && exit 1
fi
}
checkin(){
sleep 0.5
echo -e "${grey}(${green}I${grey})${green}nstall ${grey}, (${yellow}U${grey})${yellow}pdate ${grey}, (${red}R${grey})${red}emove ${grey}:${bkwhite}\n"
read -r choix
if [ "$choix" == "i" ] || [ "$choix" == "I" ]; then 
 echo -e "${grey}--> ${bkwhite}New and Clean installation of Bitcanna wallet${bkwhite}"
 sleep 0.5
if [[ ! -a $(find "/usr/bin" -name "$BCNAD") ]] ; then
  bcnadown
  choice
  console
 else
  echo -e "${grey}--> ${yellow}Detected Bitcanna wallet already installed!\n${grey}--> ${bkwhite}Please Run Update${endc}" && exit 1
 fi
elif [ "$choix" == "u" ] || [ "$choix" == "U" ]; then 
  echo -e "${grey}--> ${bkwhite}Update to last version of Bitcanna wallet${grey}...${bkwhite}"
 if [[ -a $(find "/usr/bin" -name "$BCNAD") ]] ; then
   echo -e "${grey}--> ${green}Old Bitcanna version found!\n${grey}--> ${bkwhite}UPDATING Bitcanna${bkwhite}"
   "$BCNACLI" stop > /dev/null 2>&1 || echo -e "${grey}--> ${yellow}Bitcanna Wallet is not Running${grey}...${bkwhite}"
   sleep 5
   rm -R "$BCNADIR"
   sudo rm -f /usr/bin/bitcanna*
   bcnadown
   mess
   echo -e "${grey}--> ${green}Bitcanna Wallet Updated to NEW version: $GETLAST ${bkwhite}\n To start wallet run: bitcannad -daemon" && sleep 0.5
  else
   echo -e "${grey}--> ${red}Can not find Bitcanna Wallet ${grey}!!!\n${green}Install It First ${grey}!!!\n${endc}" && exit 1
  fi
elif [ "$choix" == "r" ] || [ "$choix" == "R" ]; then 
 if [[ -a $(find "/usr/bin" -name "$BCNAD") ]] ; then
   echo -e "${grey}--> ${yellow}Old Bitcanna version found!\n${grey}--> ${red}FULL REMOVING Bitcanna${bkwhite}" && sleep 0.5
   "$BCNACLI" stop > /dev/null 2>&1 || echo -e "${grey}--> ${yellow}Bitcanna Wallet is not Running${grey}...${bkwhite}"
   sleep 5
   cp -f -r --preserve "$BCNACONF" "$BCNACONF"."$DATENOW"
   mess
   rm BCNA-Console.sh
   sed -i '/BCNACONSOLE/,/BCNACONSOLE/d' "$BCNAHOME"/.bashrc
   rm BCNA-ExtractPeerList.sh
   rm BCNA-Recalc.sh
   rm -R "$BCNACONF"
   rm -R "$BCNADIR"
   sudo rm -f /usr/bin/bitcanna*
   echo -e "${grey}--> ${red}Bitcanna Wallet ${green}FULLY ${red}Removed ${grey}!!!${bkwhite}"
  else
   echo -e "${grey}--> ${red}Bitcanna Wallet not exist!\n${green}Install it${grey}...\n${endc}" && exit 1
  fi
 else
  echo -e "${grey}--> ${red}Choose a correct option${grey}!\n${red}Exiting${grey}...${endc}" && exit 1
fi
}
bcnadown(){
echo -e "${grey}--> ${bkwhite}Lets Download and Extract the Bitcanna Wallet from GitHub\n${bkwhite}"
sleep 0.5
[ -d "$BCNACONF" ] && cp -f -r --preserve "$BCNACONF" "$BCNACONF.${DATENOW}"
[ ! -e "$BCNAPKG" ] && echo -e "${grey}--> ${bkwhite}Downloading $BCNAPKG Repository ${grey}...." && git clone "$BCNAREP" && sudo chmod -R a+rwx "$BCNAREP" && cd "$BCNAREP" || exit

sudo sed -i 's/#include "util.h"/#include <atomic>/' /home/pi/BCNA/src/net.h
./autogen.sh && ./configure CXXFLAGS="--param ggc-min-expand=1 --param ggc-min-heapsize=32768" CPPFLAGS="-I/usr/local/BerkeleyDB.4.8/include -O2" LDFLAGS="-L/usr/local/BerkeleyDB.4.8/lib" --disable-tests --with-miniupnpc --enable-upnp-default && make -j4 && sudo make install
cd || exit
echo -e "${grey}--> ${bkwhite}Copy binaries to right place ${grey}!!\n${bkwhite}"
sudo cp -f "$BCNADIR"/* /usr/bin
sudo chmod -R a+rwx /usr/bin/bitcanna* 
echo -e "${grey}--> ${green}Downloaded and Compiled${bkwhite}"
echo -e "${grey}--> ${bkwhite}Putting Bitcanna Community Scripts on right place ${grey}...\n${bkwhite}"
ln -f BCNA-Installer/BCNA-ExtractPeerList.sh BCNA-ExtractPeerList.sh
ln -f BCNA-Installer/BCNA-Recalc.sh BCNA-Recalc.sh
sleep 0.5
echo -e "\n${grey}--> ${bld}${sbl}${green}Preparing Backups Info structure ${grey}...${bkwhite}\n"
mkdir "$BCNAHOME"/BCNABACKUP
cat <<EOF >> "$BCNAHOME"/BCNABACKUP/walletinfo.txt
Bitcanna Node Info Generated in $DATENOW

Host:        $HOSTNAME
IP:          $VPSIP
EOF
}
firstrun(){
echo -e "${grey}--> ${bkwhite}First Run of Bitcanna Wallet ${grey}... ${bkwhite}"
echo -e "${grey}--> ${bkwhite}Lets Generate Random RPC User and Password ${grey}... ${bkwhite}"
sudo mkdir "$BCNACONF" > /dev/null 2>&1
sudo chmod -R a+rwx "$BCNACONF"
touch "$BCNACONF"/bitcanna.conf
RPCPWD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
echo "rpcuser=bitcanna$USER
rpcpassword=$RPCPWD
listen=1
server=1
daemon=1
txindex=1
maxconnections=1000
enablezeromint=0
banscore=50
staking=1" >> "$BCNACONF"/bitcanna.conf
if [ "$choiz" == "m" ] || [ "$choiz" == "M" ] ;  then
 echo "staking=0" >> "$BCNACONF"/bitcanna.conf
fi
chmod -R a+rwx "$BCNACONF"
echo -e "${grey}--> ${green}Random RPC User and Password generated ${grey}!!! ${bkwhite}"
echo -e "${grey}--> ${yellow}Removing masternod.conf file ${grey}...${bkwhite}\n"
[ -d "$BCNACONF"/masternode.conf ] && rm "$BCNACONF"/masternode.conf  > /dev/null 2>&1
cat <<EOF >> "$BCNAHOME"/BCNABACKUP/walletinfo.txt
RPC User:    bitcanna$USER
RPC Pass:    $RPCPWD
EOF
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/BerkeleyDB.4.8/lib"
}
choice(){
firstrun
syncr
echo -e "${grey}--> ${bkwhite}Lets Check again ....!!${bkwhite}"
sleep 1.5
syncr2
echo -e "${grey}--> ${green}YES!! REALLY! Bitcanna Wallet Fully Syncronized!!!${bkwhite}"
sleep 1.5
while true
do
echo -e "${bkwhite}\n\n${grey}--> ${bkwhite}Wich you need Install/Configure ${grey}? (${green}${bld}P${grey}/${yellow}${bld}M${grey})${bkwhite}"
echo -e "${green}${bld}      P ${grey}- ${green}Full Node ${grey}(${green}POStake${grey}) ${bkwhite}\n${yellow}${bld}      M ${grey}- ${yellow}MasterNode ${grey}(${yellow}MN${grey})${bkwhite}\n"
read -r choiz
case "$choiz" in
    p|P) echo -e "${grey}--> ${bkwhite}Selected Full Node${bkwhite}"
         walletposconf
         backup
		 "$BCNACLI" stop
		 sleep 5
		 rundaemoncheck
		 "$BCNACLI" walletpassphrase "$WALLETPASS" 0 true 
		 "$BCNACLI" getstakingstatus
	     echo -e "\n${grey}--> ${green}Proof Of Stake Finished and Running ${grey}!! \n\n" 
	     break ;;
    m|M) echo -e "${grey}--> ${bkwhite}Selected Master Node Configuration${bkwhite}"
         walletmnconf
         backup
	 break ;;
      *) echo -e "${red}Really ${grey}!?!? ${red}Missed ${grey}!?"
         sleep 0.5 ;;
esac
done
}
walletposconf(){
WLTADRS=$("$BCNACLI" getaccountaddress wallet.dat)
walletrec
echo "Wallet Address:     $WLTADRS" >> "$BCNAHOME"/BCNABACKUP/walletinfo.txt
cryptwallet
rundaemoncheck
echo -e "\n\n${grey}--> ${bkwhite}Unlocking to Stake and backup data${grey}!${bkwhite}"
 "$BCNACLI" walletpassphrase "$WALLETPASS" 0 false || { echo -e "${grey}--> ${red}Bitcanna Wallet password failed\nExiting${grey}...${bkwhite}\n${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; sleep 3; "$BCNACLI" stop ; exit 1; }
BCNADUMP=$("$BCNACLI" dumpprivkey "$WLTADRS")
echo "Private Key: $BCNADUMP" >> "$BCNAHOME"/BCNABACKUP/walletinfo.txt
echo -e "${grey}--> ${green}What amount to set Split Stake ${grey}(${yellow}1 ${grey}- ${yellow}999999${grey}) ${grey}?${bkwhite}\n"
read -r STAKE
"$BCNACLI" setstakesplitthreshold "$STAKE"
echo -e "${grey}--> ${bkwhite}Staking with ${green}$STAKE ${grey}!!!${bkwhite}"
sleep 2
"$BCNACLI" walletlock
echo -e "\n${grey}--> ${bkwhite}Set to Staking forever ${grey}...${bkwhite}"
 "$BCNACLI" walletpassphrase "$WALLETPASS" 0 true || { echo -e "${grey}--> ${red}Bitcanna Wallet password failed\nExiting${grey}...${bkwhite}\n${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; sleep 3; "$BCNACLI" stop ; exit 1; }
echo -e "\n${grey}--> ${green}CONGRATULATIONS ${grey}!! ${green}BitCanna POS ${grey}- ${green}Proof-Of-Stake Configurations COMPLETED ${grey}!!!${bkwhite}\n"
sleep 1.5
echo -e "${blk}${grey}--> ${bkwhite}TIME TO SEND SOME COINS TO YOUR wallet address\n      My Wallet Address Is: ${green}${sbl}${bld}$WLTADRS${bkwhite}\n\n"
read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${bkwhite}")"
}
walletmnconf(){
read -r -p "$(echo -e "${grey}--> ${yellow}Set ID of this Masternode${grey}. Example${grey}: ${green}0 ${grey}(${bkwhite}Zer${green}0 ${grey}- ${bkwhite}To ${green}First ${bkwhite}Node${grey}, 1 ${grey}- ${bkwhite}To 2nd node${grey}, 2 ${grey}- ${bkwhite}To 3rd node${grey}... :\n${bkwhite}")" IDMN
read -r -p "$(echo -e "${grey}--> ${yellow}Set Your MasterNode wallet Alias ${grey}(Example${grey}: ${green}MN0${grey}, ${green}MN1${grey}, ${green}MN2${grey})... : \n${bkwhite}")" MNALIAS
echo -e "${grey}--> ${bkwhite}Generate your MasterNode Private Key ${grey}...${bkwhite}"
readonly MNGENK=$("$BCNACLI" masternode genkey)
echo "Masternode PrivateKey: $MNGENK" >> "$BCNAHOME"/BCNABACKUP/walletinfo.txt
echo "Masternode ID: $IDMN" >> "$BCNAHOME"/BCNABACKUP/walletinfo.txt
echo -e "${grey}--> ${bkwhite}Creating NEW Address to MASTERNODE ${grey}-> ${green}$MNALIAS ${bkwhite}"
readonly WLTADRS=$("$BCNACLI" getnewaddress "$MNALIAS")
BCNADUMP=$("$BCNACLI" dumpprivkey "$WLTADRS")
cat <<EOF >> "$BCNAHOME"/BCNABACKUP/walletinfo.txt
MN Wallet Address:     $WLTADRS
MN Wallet Label:       $MNALIAS
MN Wallet PrivateKey:  $BCNADUMP
EOF
echo -e "\n${blk}${grey}--> ${bkwhite}\tTIME TO SEND ${red}100K${bkwhite} COINS TO YOUR ${green}$MNALIAS ${bkwhite}wallet address\n\tMy Label ${green}$MNALIAS${bkwhite} and Wallet Address Is: ${green}${sbl}${bld}$WLTADRS${bkwhite}\n\tMy Label ${green}$MNALIAS${bkwhite} and MN Wallet Private Key Is: ${green}${sbl}${bld}$BCNADUMP${bkwhite}\n\tMy Label ${green}$MNALIAS${bkwhite} and Masternode Private Key Is: ${green}${sbl}${bld}$MNGENK${bkwhite}\n\n"
read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${bkwhite}")"
while true
do
read -r -p "$(echo -e "${grey}--> ${green}Insert your TXID number${grey}:\n${bkwhite}")" MYCHECKTXID
JBLOCK="txid"
retrievedata
if [ "$MYCHECKTXID" == "$JFINDATA" ] ; then
 JBLOCK="category"
 retrievedata
 if [ "$JFINDATA" == "receive" ]; then
  echo -e "\n${yellow}Transaction Information${grey}:${bkwhite}"
  JBLOCK="txid"
  retrievedata
  echo -e "${green}TXID${grey}: ${yellow}$JFINDATA${bkwhite}"
  JBLOCK="amount"
  retrievedata
  echo -e "${green}Amount${grey}: ${yellow}$JFINDATA${bkwhite}"
  JBLOCK="address"
  retrievedata
  echo -e "${green}Address${grey}: ${yellow}$JFINDATA${bkwhite}"
  JBLOCK="category"
  retrievedata
  echo -e "${green}category${grey}: ${yellow}$JFINDATA${bkwhite}\n"
  while true
  do
  read -r -p "$(echo -e "${grey}--> ${yellow}CHECK THIS ${grey}!!!\n${yellow}IT IS your transaction id ${grey}(${green}TXID${grey})? (${green}Y${grey}/${red}N${grey}) \n${bkwhite}")" CHOILIST
  case "$CHOILIST" in
   y|Y) while true
        do
         JBLOCK="bcconfirmations"
         retrievedata
         echo -e "${yellow}Confirmations${grey}: ${green}$JFINDATA${bkwhite}"
         [ "$JFINDATA" -gt "20" ] && echo -e "${green}All Confirmations completed ${grey}!!!${bkwhite}" && sleep 1.5 && break || echo -e "${bkwhite}${yellow}Please Wait until get 20 confirmations${grey}...${bkwhite}" ;
		 while [[ ${temp_counter} -gt 0 ]];
		 do
		  printf "\rChecking... %2d second(s) remaining!" ${temp_counter}
		  sleep 1
		  ((temp_counter--))
		 done
        done
        break ;;
   n|N) sleep 0.5 ;;
   *) echo -e "\n\n${red}Really ${grey}!?!? ${red}Missed ${grey}!?\n\n${bkwhite}" && sleep 0.5 ;;
  esac
  done
  break
 else
  echo -e "${red}No Receive transactions found${grey}...\n${bkwhite}" && sleep 1
 fi
else
 echo -e "${red}No Transactions found${grey}...\n${bkwhite}" && sleep 1
fi
done
echo -e "${grey}--> ${bkwhite}Auto-finding the Collateral Output ${green}TX ${bkwhite}and ${green}INDEX\n${bkwhite}"
readonly MNID=$("$BCNACLI" masternode outputs | awk -F'"' '{print $2}')
readonly MNTX=$("$BCNACLI" masternode outputs | awk -F'"' '{print $4}')
sleep 0.5
"$BCNACLI" stop
sleep 5
echo "externalip=$VPSIP" >> "$BCNACONF"/bitcanna.conf
echo "port=$BCNAPORT" >> "$BCNACONF"/bitcanna.conf
echo "$IDMN $MNALIAS $VPSIP:$BCNAPORT $MNGENK $MNID $MNTX" > "$BCNACONF"/masternode.conf
cp -f --preserve "$BCNACONF"/masternode.conf "$BCNAHOME"/BCNABACKUP/masternode.conf
read -r -p "$(echo -e "${grey}--> ${bkwhite}Running Bitcanna Wallet\n${bkwhite}\n\n${grey}--> ${bkwhite}You want Encrypt Bitcanna MasterNode Wallet with passphrase${grey}? ${grey}(${green}Y${grey}/${red}NO${grey})\n${bkwhite}")" CRYPSN
if [ "$CRYPSN" == "y" ] || [ "$CRYPSN" == "Y" ] ; then
 WALLETEXIST=0
 rundaemoncheck 
 cryptwallet
 sleep 5
 "$BCNAD" --maxconnections=1000 --daemon || { echo -e "${grey}--> ${red}Bitcanna Wallet password failed\nExiting${grey}...${bkwhite}\n${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; sleep 3; "$BCNACLI" stop ; exit 1; }
 syncheck
else
 rundaemoncheck
 echo -e "${grey}--> ${red}                ATTENTION ${grey}!!!! \n${grey}--> ${yellow} YOUR WALLET IS ${red}NOT ${yellow}PROTECTED WITH PASSWORD ${grey}!!!!${bkwhite}\n"
 sleep 1.5
fi
echo -e "${grey}--> ${bkwhite}Activating MasterNode ${grey}...\n${bkwhite}"
if [ "$CRYPSN" == "y" ] || [ "$CRYPSN" == "Y" ]; then
 "$BCNACLI" masternode start-many "$WALLETPASS" || { echo -e "${grey}--> ${red}Bitcanna Wallet password failed\nExiting${grey}...${bkwhite}\n${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; sleep 3; "$BCNACLI" stop ; exit 1; }
else
 "$BCNACLI" masternode start-many || { echo -e "${grey}--> ${red}Bitcanna Wallet password failed\nExiting${grey}...${bkwhite}\n${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; sleep 3; "$BCNACLI" stop ; exit 1; }
fi
}
syncr(){
echo -e "${grey}--> ${bkwhite}Syncronization${bkwhite}\n\n   ${bkwhite}Which mode do you want to sync ? ${grey}(${green}${bld}B${grey}/${yellow}${bld}S${grey})${bkwhite}"
echo -e "${green}${bld}      B ${grey}- ${green}By Bootstrap ${bkwhite}\n${yellow}${bld}      S ${grey}- ${yellow}By network sync${bkwhite}\n"
read -r choicc
case "$choicc" in
 b|B) echo -e "${grey}--> ${bkwhite}Getting Bootstrap ${grey}...${bkwhite}"
  if [[ -n $(find ~ -name "$GETLASTBOOT.zip") ]]; then
   echo -e "${grey}--> ${green}Found $GETLASTBOOT.zip on local storage${bkwhite}"
  else
   echo -e "${grey}--> ${bkwhite}Downloading $GETLASTBOOT.zip ${grey}...${bkwhite}" 
   wget "$BCNABOOT" -P "$BCNAHOME" > /dev/null 2>&1
  fi
  echo -e "${grey}--> ${bkwhite}Extracting $GETLASTBOOT.zip into $BCNACONF ${grey}..."
  unzip -o "$BCNAHOME"/"$GETLASTBOOT".zip -d "$BCNACONF" > /dev/null 2>&1
  ;;
 s|S) echo -e "${grey}--> ${bkwhite}Network Syncronization ${grey}...${bkwhite}" ;;
      # cp -R .bitcannabck/* .bitcanna ;;
 *) echo -e "${grey}--> ${yellow}Really ${grey}??? ${yellow}Missed ${grey}!?${bkwhite}\n"
  sleep 1 ;;
esac
echo
rundaemoncheck
syncr2 
}
syncr2(){
echo -e "${grey}--> ${bkwhite}Starting Syncronization ${grey}...${bkwhite}"
diff_t="420" ; while [ "$diff_t" -gt "7" ]
do 
clear
echo -e "${red}      __   __     _____   ______ \n${red}     /__/\/__/\  /_____/\/_____/\ 
${red}     \  \ \\${green}: ${red}\ \_\\${green}:::${red}_${green}:${red}\ \\${green}:::${red}_ \ \ 
${red}      \\${green}::${red}\_\\${green}::${red}\/_/\  _\\${green}:${red}\|\\${green}:${red}\ \ \ \ 
${red}       \_${green}:::   ${red}__\/ /${green}::${red}_/__\\${green}:${red}\ \ \ \   
${red}            \\${green}::${red}\ \  \\${green}:${red}\____/\\${green}:${red}\_\ \ \  
${red}             \__\/   \_____\/\_____\/
${green}     T I M E${bkwhite}"
echo -e "${blk}${grey}!!! ${yellow}PLEASE WAIT TO FULL SYNCRONIZATION ${grey}!!!\n"
BLKCNT=$("$BCNACLI" getblockcount)
BLKHSH=$("$BCNACLI" getblockhash "$BLKCNT")
t=$("$BCNACLI" getblock "$BLKHSH" | grep '"time"' | awk -F ":" '{print $2}' | sed -e 's/,$//g')
cur_t=$(date +%s)
diff_t=$(("$cur_t" - "$t"))
echo -n -e "${grey}--> ${yellow}Remaining${grey}: ${green}"
echo "$diff_t" | awk '{printf "%d days, %d:%d:%d\n",$1/(60*60*24),$1/(60*60)%24,$1%(60*60)/60,$1%60}'
sleep 7
done
}
walletrec(){
while true
do
echo -e "${grey}--> ${green}Choose method to recover your wallet${grey}?${bkwhite}\n"
echo -e "${green}${bld}\tW ${grey}- ${yellow}by wallet.dat file ${grey}(${red}NOT Recommended${grey})${bkwhite}\n${green}${bld}\tK ${grey}- ${yellow}by Private Key ${grey}(${green}Recommended${grey})${bkwhite}\n${green}${bld}\tN ${grey}- ${yellow}NOT Recover. Create a NEW wallet${grey}!!!${bkwhite}\n"
read -r choic
case "$choic" in
    w|W) echo -e "${grey}--> ${bkwhite}Detecting wallet.dat file ${grey}... ${bkwhite}"
	     sleep 0.5
	     while [ ! -f "$BCNAHOME"/wallet.dat ]
         do		 
		  echo -e "\n${grey}--> ${yellow}wallet.dat not found ${grey}...${bkwhite}\n ${green}Please, put wallet.dat on this directory ${grey}: ${yellow}$BCNAHOME/wallet.dat ${bkwhite}\n"
		  read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${bkwhite}")"
         done
         echo -e "\n${grey}--> ${green}wallet.dat FOUND in ${yellow}$PWD ${green}Directory${grey}...${bkwhite}\n"
		 "$BCNACLI" importwallet "$BCNAHOME"/wallet.dat
		 sleep 0.5
         WALLETEXIST=1
         break ;;
    k|K) echo -e "${bld}${green}Put PRIVATE KEY of Recovering wallet${grey}:"
	     read -r WALLETPRIVK
         "$BCNACLI" importprivkey "$WALLETPRIVK" MyOldBCNAWallet false
         WALLETEXIST=0
	     break ;;
	n|N) echo -e "${grey}--> ${yellow} Creating a NEW Wallet${grey}... ${bkwhite}" 
         WALLETEXIST=0
		 sleep 0.5 && break ;;
    *) echo -e "${red}Really ${grey}!?!? ${red}Missed ${grey}!?" && sleep 0.5 ;;
esac
done
}
cryptwallet(){
if [ "$WALLETEXIST" -eq 0 ] ; then
 WALLETPASS="dummy1"
 WALLETPASSS="dummy2"
 while [ "$WALLETPASS" != "$WALLETPASSS" ]
 do
  echo -e "${bld}${green}Set PassPhrase to wallet.dat${grey}:" && read -rsp "" WALLETPASS
  echo -e "${bld}${yellow}Repeat PassPhrase again${grey}: ${bkwhite}" && read -rsp "" WALLETPASSS
 done
 echo "Wallet Passphrase : $WALLETPASS" >> "$BCNAHOME"/BCNABACKUP/walletinfo.txt
 "$BCNACLI" encryptwallet "$WALLETPASS" || { echo -e "${grey}--> ${red}Bitcanna Wallet password failed\nExiting${grey}...${bkwhite}\n${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; sleep 3; "$BCNACLI" stop ; exit 1; }
 sleep 3
 echo -e "${grey}--> ${green}Bitcanna wallet.dat Encrypted ${grey}!!!${bkwhite}\n\n"
 sleep 1
elif [ "$WALLETEXIST" -eq 1 ] ; then
 WALLETPASS="dummy1"
 WALLETPASSS="dummy2"
 while [ "$WALLETPASS" != "$WALLETPASSS" ]
 do
  echo -e "${bld}${green}Put your ${yellow}wallet.dat ${green}PassPhrase${grey}:${bkwhite}" && read -rsp "" WALLETPASS
  echo -e "${bld}${green}Repeat your ${yellow}wallet.dat ${green}PassPhrase${grey}: ${bkwhite}" && read -rsp "" WALLETPASSS
 done
fi
}
rundaemoncheck(){
"$BCNAD" -daemon
syncheck
}
syncheck(){
while true
do 
 sleep 10
 "$BCNACLI" getinfo > /dev/null 2>&1 && break || echo -e "${bkwhite}${yellow}Wait ${grey}...${bkwhite}" ;
 sleep 10
done
}
retrievedata(){
JNUMDATA=$("$BCNACLI" listtransactions "$MNALIAS" | awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'"$JBLOCK"'\042/){print $(i+1)}}}' | tr -d '" ' | wc -l)
JFINDATA=$("$BCNACLI" listtransactions "$MNALIAS" | awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'"$JBLOCK"'\042/){print $(i+1)}}}' | tr -d '" ' | sed -n "$JNUMDATA"p)
}
backup(){
if [ "$CRYPSN" == "y" ] || [ "$CRYPSN" == "Y" ] ; then 
 "$BCNACLI" walletpassphrase "$WALLETPASS" 0 false
fi
"$BCNACLI" backupwallet "$BCNAHOME"/BCNABACKUP/wallet.dat
sleep 0.5
echo -e "\n${grey}--> ${bkwhite}Compacting Files ${grey}...${bkwhite}\n"
zip -r -q "$BCNAHOME"/WalletBackup BCNABACKUP || tar --overwrite -zcvf "$BCNAHOME"/WalletBackup.tar.gz BCNABACKUP
chmod 600 "$BCNAHOME"/WalletBackup.*
echo -e "\n\n${grey}--> ${bkwhite}Info Wallet Backuped on${grey}:${bld}${sbl}${green} $BCNAHOME/WalletBackup.tar.gz \n${yellow}\t${grey}!!! ${yellow}PLEASE ${grey}!!!\n${red}\tSAVE THIS FILE IN MANY DEVICES IN A SECURE PLACE${bkwhite}\n"
read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${bkwhite}")"
}
console(){
sed -i "s/BCNAMODE=\"NONE\"/BCNAMODE=\"$choiz\"/" BCNA-Installer/BCNA-Console.sh
echo -e "\n\n${grey}--> ${bkwhite}You want get a Bitcanna Terminal on user login ${grey}??? (${green}Y${grey}/${red}N${grey})${bkwhite}\n"
read -r MYTERM
if [ "$MYTERM" == "Y" ] || [ "$MYTERM" == "y" ] ; then
 ln -f BCNA-Installer/BCNA-Console.sh BCNA-Console.sh
 if grep -Fxq "BCNA-Console.sh" "$BCNAHOME"/.bashrc ; then
  echo -e "${grey}--> ${yellow}BCNA-Console.sh Existing on $BCNAHOME/.bashrc ${grey}!!!${bkwhite}\n"
 else
 cat <<EOF >> "$BCNAHOME"/.bashrc
### BCNACONSOLE ###
if [ -f "$BCNAHOME"/BCNA-Console.sh ]; then
 . BCNA-Console.sh
fi
### BCNACONSOLE ###
EOF
  echo -e "${grey}--> ${bkwhite}Bitcanna Terminal set for user ${green}$USER ${grey}!!!${bkwhite}\n"
 fi
else
 echo -e "${grey}--> ${yellow}Will not get a Bitcanna Terminal ${grey}!!!\n${green}You can run${yellow} 'bash $BCNAHOME/BCNA-Installer/BCNA-ExtractPeerList.sh' ${green}script on future ${grey}!!!${bkwhite}\n" 
 sleep 1
fi 
}
mess(){
echo -e "${grey}--> ${yellow}Cleaning the things ${grey}...${bkwhite}"
[ -d "$(find "$BCNAHOME" -name "*MACOSX*" )" ] && rm -R -f "$BCNAHOME"/*MACOSX*
[ -d "$(find "$BCNAHOME" -name "unix-*" )" ] && rm -R -f "$BCNAHOME"/unix-*
[ -d "$(find "$BCNAHOME" -name "unix_*" )" ] && rm -R -f "$BCNAHOME"/unix_*
[ -d "$(find "$BCNAHOME" -name "$BCNAPKG" )" ] && rm -R -f "$BCNAHOME"/bcna-"$GETLAST"-unix*
[ -d "$(find "$BCNAHOME" -name "BCNABACKUP" )" ] && rm -R -f "$BCNAHOME"/BCNABACKUP
[ -d "$(find "$BCNAHOME" -name "$BCNADIR" )" ] && rm -R -f "$BCNADIR"
[[ "$choicc" == "b" || "$choicc" == "B" ]] && rm "$BCNACONF"/bootstrap.dat.old
echo "${grey}--> ${green}Cleaned unecessary storage ${grey}!!!${bkwhite}"
sleep 1.5
}
concl(){
echo -e "${bkwhite}${green}\n\t\t __    ___  __  \n\t\t|__) |  |  /  \`  /\  |\ | |\ |  /\  \n\t\t|__) |  |  \__, /~~\ | \| | \| /~~\ ${bkwhite}\n\n"
echo -e "${green}\tProject Ver${grey}: ${bld}${bkwhite}$SCRPTVER${green}\n\tby${grey}: ${bld}${bkwhite} hellresistor\n\n\tDonation with Bitcanna\n\t${green}BCNA${grey}: ${yellow}${bld}${sbl}$DONATE${bkwhite}\n${endc}"
}
###############
#### Start ####
###############
colors
varys

if [[ "$EUID" -eq 0 ]]; then 
 echo -e "${grey}--> ${red}You are root ${grey}!!\n   ${yellow}Just NOT USE ROOT user ${grey}!!!\n      ${red}Exiting${grey}...${endc}" && sleep 0.5 && exit 1
else
 case "$OSTYPE" in
  linux*) echo -e "${grey}--> ${yellow}Please${grey}, ${bkwhite}Get the Script dedicated to Linux (Ubuntu Debian) ${grey}!!!${bkwhite}" && sleep 1 && exit 1 ;;
  arm64*) intro && read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${bkwhite}")" && preraspberry  ;;
       *) echo -e "${grey}--> ${red}Operating System Unknown ${grey}!!!\n${red}Exiting${grey}...${endc}" && sleep 1 && exit 1 ;;
 esac
 MYSUDOER=$(sudo grep '^$USER' /etc/sudoers)
 if [[ "$MYSUDOER" -eq 0 ]]; then
  sudo apt update > /dev/null 2>&1
 else
  echo -e "${red}ERROR${grey}!!! ${bkwhite}User${grey}:${yellow}$USER ${bkwhite}is not a sudoer user\nExiting${grey}...${bkwhite}" && sleep 0.2 
  echo -e "${yellow}$USER user need sudoer privileges to set bitcannad and bitcanna-cli binaries ${grey}!!!${bkwhite}" && sleep 0.2
  exit 1
 fi
 echo -e "${grey}--> ${bkwhite}Nice user${grey}: ${green}$USER ${grey}!! \n${green}Continuing${grey}...${bkwhite}" && sleep 0.7
 cd "$BCNAHOME" || { echo -e "${grey}--> ${red}$BCNAHOME Cant Found!\nExiting...${endc}"; exit 1; }
 clear
 intro
 checkin
 mess
 concl
 history -cw
 echo -e "${endc}"
fi
if [ "$MYTERM" = "Y" ] || [ "$MYTERM" = "y" ]; then
 bash BCNA-Console.sh
fi

