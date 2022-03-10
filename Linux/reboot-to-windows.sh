#!/bin/bash

# Reboot directly to Windows
# Inspired by http://askubuntu.com/questions/18170/how-to-reboot-into-windows-from-ubuntu
windows_title=$(grep -i windows /boot/grub2/grub.cfg | cut -d "'" -f 2)
grub-reboot "$windows_title" && systemctl reboot
