#!/usr/bin/bash
zenity --password --title="Enter sudo password" \
  | sudo -S grub-reboot Windows \
  && shutdown -r now

  
