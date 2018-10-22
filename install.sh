#!/bin/bash

## Asks for information and writes it on their files

printf "Domainserver name?\n\n"
read domainServer

printf "Now lets create a password for root\n\n"

printf "Password for root:\n"
passwd

printf "And lets add a user, with the name...\nuser: "
read userName

useradd -m -G wheel $userName
passwd $userName
printf "\n$userName ALL=(ALL) ALL" >> /etc/sudoers

while true; do
	printf "Choose your DE/WM\n\n"

	printf "[1] i3\n"
	printf "[2] KDE Plasma\n"
	printf "[3] Gnome\n\n"
	read deChoice

	if [ "$deChoice" -eq "1" ]; then
		break
	fi

	if [ "$deChoice" -eq "2" ]; then
		break
	fi

	if [ "$deChoice" -eq "3" ]; then
			break
	fi

	clear
	printf "Wrong number\n\n"

done

clear

printf "Setting timezone (Argentina)\n\n"

ln -sf /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime

printf "Running hwclock()\n\n"

hwclock --systohc

printf "Configuring locale.gen\n\n"

rm -rf /etc/locale.gen 
cp configs/locale/locale.gen /etc/locale.gen
locale-gen

printf "Setting language to english\n\n"

rm -rf /etc/locale.conf
cp configs/locale/locale.conf /etc/locale.conf

printf "Making configurations\n\n"

rm -rf /etc/pacman.conf
cp configs/pacman/pacman.conf /etc/pacman.conf
rm -rf /etc/pacman.d/mirrorlist
cp configs/pacman/mirrorlist /etc/pacman.d/mirrorlist

printf "\n127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t$domainServer.localdomain\t$domainServer" >> /etc/hosts

clear

## Downloads programs

printf "Go and make yourself a coffe, this is going to take a while\n\n"

printf "Downloading stuff\n\n"

## installs i3

if [ $deChoice -eq 1 ]; then

pacman -S --noconfirm bash-completion vim dialog wpa_supplicant intel-ucode grub i3 dmenu xorg xorg-xinit firefox vlc rxvt-unicode xf86-video-intel thunderbird compton pulseaudio feh wget unzip nautilus htop adobe-source-code-pro-fonts noto-fonts-cjk acpi libreoffice sddm alsa alsa-utils

systemctl enable sddm

clear

fi

## installs kde plasma

if [ $deChoice -eq 2 ]; then

pacman -S --noconfirm bash-completion vim intel-ucode grub xorg xorg-xinit firefox vlc xf86-video-intel thunderbird pulseaudio wget unzip htop adobe-source-code-pro-fonts noto-fonts-cjk acpi libreoffice sddm alsa alsa-utils plasma kde-applications

systemctl enable sddm
systemctl disable dhcpcd
systemctl enable NetworkManager

rm -rf /usr/lib/sddm/sddm.conf.d/default.conf
cp configs/sddm/default.conf /usr/lib/sddm/sddm.conf.d/default.conf

clear

fi

## installs gnome

if [ $deChoice -eq 3 ]; then

pacman -S --noconfirm bash-completion vim intel-ucode grub xorg xorg-xinit firefox vlc xf86-video-intel thunderbird pulseaudio wget unzip htop adobe-source-code-pro-fonts noto-fonts-cjk acpi libreoffice sddm alsa alsa-utils gnome gnome-extra gdm 

systemctl enable gdm
systemctl disable dhcpcd
systemctl enable NetworkManager

clear

fi

## Installs rcs

printf "Installing rcs\n\n"

git clone https://github.com/supermarin/YosemiteSanFranciscoFont
cd YosemiteSanFranciscoFont/
mkdir /home/$userName/.fonts
cp *.ttf /home/$userName/.fonts
cd ..
rm -rf YosemiteSanFranciscoFont

cp configs/yaourt/yaourtrc /etc/yaourtrc

rm -rf /home/$userName/.Wallpapers
mkdir /home/$userName/.Wallpapers
cp rcs/wallpaper/Wallpaper.png /home/$userName/.Wallpapers

rm -rf /home/$userName/.bashrc
cp rcs/bashrc/.bashrc /home/$userName/.bashrc

rm -rf /home/$userName/.bash_profile
cp configs/bash_profile/.bash_profile /home/$userName/.bash_profile

rm -rf /home/$userName/.Xresources
cp rcs/xresources/.Xresources /home/$userName/.Xresources

mkdir /home/$userName/.config/
mkdir /home/$userName/.config/i3
cp rcs/i3/config /home/$userName/.config/i3

rm -rf /home/$userName/.i3blocks.conf
cp rcs/i3blocks/.i3blocks.conf /home/$userName/.i3blocks.conf

rm -rf /home/$userName/.gtkrc-2.0
cp rcs/gtk-2.0/.gtkrc-2.0 /home/$userName/.gtkrc-2.0

rm -rf /home/$userName/.config/gtk-3.0
mkdir /home/$userName/.config/gtk-3.0
cp rcs/gtk-3.0/settings.ini /home/$userName/.config/gtk-3.0

rm -rf /home/$userName/.config/compton.conf
cp rcs/compton/compton.conf /home/$userName/.config/compton.conf

rm -rf /home/$userName/.i3blocks.conf
cp rcs/i3blocks/.i3blocks.conf /home/$userName/.i3blocks.conf

mkdir /home/$userName/.tmp

chown -hR $userName /home/$userName/

## Installs and configures GRUB

printf "Installing GRUB\n\n"

rm -rf /etc/default/grub
cp configs/grub/grub /etc/default/grub
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

printf "the system installation is done, you can run installYaourt.sh or reboot your system now\n"

su $userName
