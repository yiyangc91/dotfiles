#!/bin/bash

if [[ $# -ne 1 ]]; then
   echo "$0 [on/off]" >&2
   exit 2
fi

case "$1" in
   on)
      ;;
   off)
      bluetoothctl power off
      sudo systemctl stop bluetooth
      ;;
esac
