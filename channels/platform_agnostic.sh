#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo -e "\e[1;31mThis program must be run as root" 
   exit 1
fi

cp -r /usr/src/UX/SRC/base/* /
chmod +x /usr/bin/uxdate