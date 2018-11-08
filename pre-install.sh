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

## reads user value for the amount of space on partitions

clear

printf "In what disk do you want to install Arch Linux on? (eg: /dev/sda): "

read userDisk

clear

printf "Size of swap partition? (eg: 8G): " 

read userSwap

clear

## prepares the GPT table and format the disks

printf "Deleting current GPT and MBR tables from disk $userDisk\n\n"

printf "x\nz\ny\ny\n" | gdisk $userDisk 1>/dev/null

printf "Making GPT\n\n"

printf "n\n\n\n+1M\nef02\nn\n\n\n+$userSwap\n8200\nn\n\n\n\n\nw\ny\n" | gdisk /dev/sda 1>/dev/null

printf "Formating partitions\n\n"

mkswap /dev/sda2 1>/dev/null
mkfs.ext4 /dev/sda3 1>/dev/null

clear

printf "Mounting file systems\n\n"

swapon /dev/sda2 1>/dev/null
mount /dev/sda3 /mnt 1>/dev/null

clear

## sets configurations

printf "Setting timedate...\n"

timedatectl set-ntp true

clear

## configures pacman and its mirrorlists

printf "Configuring pacman mirrorlist\n\n"
rm -rf /etc/pacman.d/mirrorlist
cp configs/pacman/mirrorlist /etc/pacman.d/mirrorlist
rm -rf /etc/pacman.conf
cp configs/pacman/pacman.conf /etc/pacman.conf

clear

## download the system

printf "Time to download the OS\n\n"

pacstrap /mnt base base-devel

clear

## creates the fstab

printf "Generating the fstab file\n\n"

genfstab -U /mnt >> /mnt/etc/fstab

clear

printf "Entering your new system\n\n"
printf "Clone the repo again and run ./install.sh\n\n"

arch-chroot /mnt
