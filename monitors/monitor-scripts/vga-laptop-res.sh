#!/bin/bash
xrandr --newmode "1368" 85.25 1368 1440 1576 1784 768 771 781 798 -hsync +vsync
xrandr --addmode VGA1 1368
xrandr --output VGA1 --mode 1368
