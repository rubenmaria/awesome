#!/bin/bash

#monitor config
~/.config/awesome/monitors/monitor-scripts/monitor3.sh

#zsh config dir
export ZDOTDIR=$HOME/.config/zsh

#exec monitor3.sh
#/home/rubs/.config/polybar/launch.sh

# logitech mouse driver
logid

#Headset crackling fix
hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x67 
hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x3000
