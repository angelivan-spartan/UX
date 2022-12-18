#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo -e "\e[1;31mThis program must be run as root" 
   exit 1
fi

chmod 4755 /sbin/shutdown
chmod 4755 /sbin/reboot

echo "Updating System..."
apt -y update
apt -y upgrade
apt -y install exfat-fuse python3 libncurses5 fte-terminal