#!/bin/bash

echo "Looking for internet conection."

while true; do
	ping -c 1 archlinux.org 1>/dev/null
	if [ $? -ne 0 ]; then
		printf "Unable to access internet.\n"
		printf "Use wifi-menu if you are on wireless.\n\n"
	else 
		printf "Conection detected.\n\n"
		break
	fi
	sleep 2
done

printf "Setting timedate...\n"

timedatectl set-ntp true

printf "Done.\n\n"

printf "Partitioning disks.\n\n"

printf "Deleting GPT and MBR.\n\n"

printf "x\nz\ny\ny\n" | gdisk /dev/sda 1>/dev/null

printf "Making GPT.\n\n"

printf "n\n\n\n+1M\nef02\nn\n\n\n+8G\n8200\nn\n\n\n\n\nw\ny\n" | gdisk /dev/sda 1>/dev/null

printf "Partitioning disk\n\n"
