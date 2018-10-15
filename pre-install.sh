#!/bin/bash

## looks for your internet connection

echo "Looking for internet conection"

while true; do
	ping -c 1 archlinux.org 1>/dev/null
	if [ $? -ne 0 ]; then
		printf "Unable to access internet\n"
		printf "Use wifi-menu if you are on wireless\n\n"
	else 
		printf "Conection detected\n\n"
		break
	fi
	sleep 2
done

## sets configurations

printf "Setting timedate...\n"

timedatectl set-ntp true

printf "Done\n\n"

printf "Partitioning disks\n\n"

## prepares the GPT table and format the disks

printf "Deleting GPT and MBR\n\n"

printf "x\nz\ny\ny\n" | gdisk /dev/sda 1>/dev/null

printf "Making GPT\n\n"

printf "n\n\n\n+1M\nef02\nn\n\n\n+8G\n8200\nn\n\n\n\n\nw\ny\n" | gdisk /dev/sda 1>/dev/null

printf "Formating partitions\n\n"

mkswap /dev/sda2 1>/dev/null
swapon /dev/sda2 1>/dev/null
mkfs.ext4 /dev/sda3 1>/dev/null

printf "Mounting file systems\n\n"

mount /dev/sda3 /mnt 1>/dev/null

## configures pacman and its mirrorlists

printf "Configuring pacman mirrorlist\n\n"
rm -rf /etc/pacman.d/mirrorlist
cp mirrorlist /etc/pacman.d/mirrorlist
rm -rf /etc/pacman.conf
cp pacman.conf /etc/pacman.conf

clear

## download the system

printf "Time to download the OS\n\n"

pacstrap /mnt base base-devel

clear

## creates the fstab

printf "Generating the fstab file\n\n"

genfstab -U /mnt >> /mnt/etc/fstab

printf "Entering your new system\n"

printf "Clone the repo again and run ./install.sh\n\n"

arch-chroot /mnt
