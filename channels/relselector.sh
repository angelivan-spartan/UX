#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo -e "\e[1;31mThis program must be run as root" 
   exit 1
fi

rel=`lsb_release -rs`
case $rel in

  rp32)
    bash /usr/src/UX/channels/deps_rp32.sh
    ;;

  dwsl)
    bash /usr/src/UX/channels/deps_dwsl.sh
    ;;

  *)
    echo -e "\e[1;31mUnknown release ($rel)"
    ;;
esac
