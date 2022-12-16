#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo -e "\e[1;31mThis program must be run as root ( $0)" 
   exit 1
fi
chmod 4755 /sbin/shutdown
chmod 4755 /sbin/reboot
echo "Updating System..."
apt -y update
apt -y upgrade
apt -y install python3
apt -y install libncurses5
apt -y install fte-terminal


if [[ -d /usr/bin/dotnet7 ]]; then
echo -e "" 
else
echo "Installing FBC..."
cd /tmp
wget https://users.freebasic-portal.de/stw/builds/linux-armv6-rpi/fbc_linux_armv6_rpi_0528_2022-06-24.zip
unzip fbc_linux_armv6_rpi_0528_2022-06-24.zip
cd fbc_linux_armv6_rpi
chmod +x install.sh
 ./install.sh -i
cd ..
rm -rf fbc_linux_armv6_rpi
rm -f fbc_linux_armv6_rpi_0528_2022-06-24.zip


if [[ -d /usr/bin/powershell ]]; then
echo -e "" 
else
echo "Installing PowerShell..."
cd /tmp
apt install '^libssl1.0.[0-9]$' libunwind8 -y
wget https://github.com/PowerShell/PowerShell/releases/download/v7.3.1/powershell-7.3.1-linux-arm32.tar.gz
mkdir /usr/bin/powershell
tar -xvf ./powershell-7.3.1-linux-arm32.tar.gz -C /usr/bin/powershell
chmod +x /usr/bin/powershell/pwsh
ln -sf /usr/bin/powershell/pwsh /usr/bin/pwsh
rm powershell-7.3.1-linux-arm32.tar.gz
fi


if [[ -d /usr/bin/dotnet7 ]]; then
echo -e "" 
else
echo "Installing .Net7..."
dotnetver=7.0
sdkfile=/tmp/dotnetsdk.tar.gz
aspnetfile=/tmp/aspnetcore.tar.gz
download() {
    [[ $downloadspage =~ $1 ]]
    linkpage=$(wget -qO - https://dotnet.microsoft.com${BASH_REMATCH[1]})

    matchdl='id="directLink" href="([^"]*)"'
    [[ $linkpage =~ $matchdl ]]
    wget -O $2 "${BASH_REMATCH[1]}"
}
apt -y install libunwind8 gettext
rm -f $sdkfile
rm -f $aspnetfile
[[ "$dotnetver" > "5" ]] && dotnettype="dotnet" || dotnettype="dotnet-core"
downloadspage=$(wget -qO - https://dotnet.microsoft.com/download/$dotnettype/$dotnetver)
    arch=arm32
    if command -v uname > /dev/null; then
        machineCpu=$(uname -m)-$(uname -p)

        if [[ $machineCpu == *64* ]]; then
            arch=arm64
        fi
    fi
download 'href="([^"]*sdk-[^"/]*linux-'$arch'-binaries)"' $sdkfile
download 'href="([^"]*aspnetcore-[^"/]*linux-'$arch'-binaries)"' $aspnetfile
mkdir /usr/bin/dotnet7/
tar -xvf $sdkfile -C /usr/bin/dotnet7/
tar -xvf $aspnetfile -C /usr/bin/dotnet7/
rm -f $sdkfile
rm -f $aspnetfile
ln -sf /usr/bin/dotnet7/dotnet /usr/bin/dotnet
if grep -q 'export DOTNET_ROOT=' /etc/environment;  then
  echo 'Already added link to environment'
else
  echo 'export DOTNET_ROOT=/usr/bin/dotnet7' >> /etc/environment
fi
export DOTNET_ROOT=/usr/bin/dotnet7
fi
