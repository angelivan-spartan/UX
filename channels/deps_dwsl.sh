#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo -e "\e[1;31mThis program must be run as root" 
   exit 1
fi

chmod 4755 /sbin/shutdown
chmod 4755 /sbin/reboot

apt -y update
apt -y upgrade
apt -y install exfat-fuse python3 libncurses5 fte-terminal

if [[ -d /usr/bin/dotnet7 ]]; then
echo -e "" 
else
echo "Installing .Net7..."
dotnetver=7.0
cd /tmp/
wget https://dot.net/v1/dotnet-install.sh
bash dotnet-install.sh --channel 7.0
rm dotnet-install.sh
mv ~/.dotnet /usr/bin/dotnet7
ln -sf /usr/bin/dotnet7/dotnet /usr/bin/dotnet
if grep -q 'export DOTNET_ROOT=' /etc/environment;  then
  echo 'Already added link to environment'
else
  echo 'export DOTNET_ROOT=/usr/bin/dotnet7' >> /etc/environment
fi
export DOTNET_ROOT=/usr/bin/dotnet7
fi