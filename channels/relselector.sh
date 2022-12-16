#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo -e "\e[1;31mThis program must be run as root (sudo $0)" 
   exit 1
fi

case `lsb_release -rs` in

  rp32)
    bash /tmp/UX/channels/deps_rp32.sh
    ;;


  *)
    echo "Unknown release"
    ;;
esac
