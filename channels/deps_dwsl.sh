#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo -e "\e[1;31mThis program must be run as root" 
   exit 1
fi

chmod 4755 /sbin/shutdown
chmod 4755 /sbin/reboot

apt -y update
apt -y upgrade
apt -y install exfat-fuse python3 libncurses5 fte-terminal libfreebasic libxext-dev libncurses5-dev libx11-dev libxpm-dev libxrandr-dev libstdc++6-4.4-dev

if [[ -d /usr/local/include/freebasic ]]; then
echo -e "" 
else
echo "Installing FBC..."
cd /tmp
wget http://nchc.dl.sourceforge.net/project/fbc/Binaries%20-%20Linux/FreeBASIC%200.21.1/FreeBASIC-0.21.1-linux.tar.lzma
tar -xvf FreeBASIC-0.21.1-linux.tar.lzma
cd FreeBASIC-0.21.1-linux
chmod +x install.sh
 ./install.sh -i
cd ..
rm -rf FreeBASIC-0.21.1-linux
rm -f FreeBASIC-0.21.1-linux.tar.lzma
fi

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
if grep -q 'export DOTNET_ROOT=' /etc/profile;  then
  echo 'Already added link to profile'
else
  echo 'export DOTNET_ROOT=/usr/bin/dotnet7' >> /etc/profile
fi
export DOTNET_ROOT=/usr/bin/dotnet7
fi


