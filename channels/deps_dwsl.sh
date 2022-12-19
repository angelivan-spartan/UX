#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo -e "\e[1;31mThis program must be run as root" 
   exit 1
fi

chmod 4755 /sbin/shutdown
chmod 4755 /sbin/reboot

apt -y update
apt -y upgrade
apt -y install exfat-fuse python3 libncurses5 fte-terminal libxext-dev libncurses5-dev libx11-dev libxpm-dev libxrandr-dev libgbm1 libgl1-mesa-dri libegl1-mesa libinput10 libICE.so.6 kmscube 

if [[ -d /usr/local/include/freebasic ]]; then
echo -e "" 
else
echo "Installing FBC..."
cd /tmp
wget https://sourceforge.net/projects/fbc/files/FreeBASIC-1.07.3/Binaries-Linux/FreeBASIC-1.07.3-linux-x86_64.tar.gz
tar -xvf FreeBASIC-1.07.3-linux-x86_64.tar.gz
cd FreeBASIC-1.07.3-linux-x86_64
chmod +x install.sh
 ./install.sh -i
cd ..
rm -rf FreeBASIC-1.07.3-linux-x86_64
rm -f FreeBASIC-1.07.3-linux-x86_64.tar.lzma
fi

if [[ -d /opt/microsoft/powershell/7/pwsh ]]; then
echo -e "" 
else
echo "Installing PowerShell..."
apt install -y curl gnupg apt-transport-https
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-bullseye-prod bullseye main" > /etc/apt/sources.list.d/microsoft.list'
apt update
apt install -y powershell
fi

if [[ -d /usr/bin/dotnet7 ]]; then
echo -e "" 
else
echo "Installing .Net7..."
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


