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

1 - To expand disk space use comand -> sudo raspi-config 

2 - In the menu, choose to expand the file system

3 - then, in "Localisation options", choose "Change locale", then in the list make sure that at least "en_US.UTF-8 UTF-8" is checked

4 - Choose "OK" to build the locales

5 - Exit the Pi configuration tool and select yes when it asks to reboot.

6 - 
