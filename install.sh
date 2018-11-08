#!/bin/bash

## Asks for information and writes it on their files

repoName="thinkpad-t61-archlinux-installer"

clear

printf "Domainserver name: "
read domainServer

clear

printf "Now lets create a password for root\n"

passwd

clear

printf "Lets add a user, with the name: "
read userName

clear

useradd -m -G wheel $userName

printf "Lets create a password for the user\n"

passwd $userName
printf "\n$userName ALL=(ALL) ALL" >> /etc/sudoers

clear

while true; do
	printf "Choose your DE/WM\n\n"

	printf "[0] none\n"
	printf "[1] i3\n"
	printf "[2] KDE Plasma\n"
	printf "[3] KDE Plasma (without kde-applications)\n"
	printf "[4] KDE Plasma Minimal\n"
	printf "[5] Gnome\n"
	printf "[6] Gnome (without gnome-extra)\n\n"
	read deChoice

	if [ "$deChoice" -eq "0" ]; then
		break
	fi

	if [ "$deChoice" -eq "1" ]; then
		break
	fi

	if [ "$deChoice" -eq "2" ]; then
		break
	fi

	if [ "$deChoice" -eq "3" ]; then
			break
	fi

	if [ "$deChoice" -eq "4" ]; then
			break
	fi

	if [ "$deChoice" -eq "5" ]; then
			break
	fi

	if [ "$deChoice" -eq "6" ]; then
			break
	fi

	clear
	printf "ERROR: choose a number in the list below\n\n"

done

clear

printf "Setting timezone (Argentina)\n\n"

ln -sf /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime

clear

printf "Running hwclock()\n\n"

hwclock --systohc

clear

printf "Configuring locale.gen\n\n"

rm -rf /etc/locale.gen 
cp configs/locale/locale.gen /etc/locale.gen
locale-gen

clear

printf "Setting language to english\n\n"

rm -rf /etc/locale.conf
cp configs/locale/locale.conf /etc/locale.conf

clear

printf "Making configurations\n\n"

rm -rf /etc/pacman.conf
cp configs/pacman/pacman.conf /etc/pacman.conf
rm -rf /etc/pacman.d/mirrorlist
cp configs/pacman/mirrorlist /etc/pacman.d/mirrorlist

printf "$domainServer > /etc/hostname"

printf "\n127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t$domainServer.localdomain\t$domainServer" >> /etc/hosts

clear

## Downloads programs

printf "Go and make yourself a coffe, this is going to take a while\n\n"

sleep 5

## doesn't install a DE/WM

if [ $deChoice -eq 0 ]; then

pacman -S --noconfirm bash-completion vim dialog wpa_supplicant intel-ucode grub wget unzip htop acpi alsa alsa-utils

systemctl enable sddm

clear

fi

## installs i3

if [ $deChoice -eq 1 ]; then

pacman -S --noconfirm bash-completion vim dialog wpa_supplicant intel-ucode grub i3 dmenu xorg xorg-xinit firefox vlc rxvt-unicode xf86-video-intel thunderbird compton pulseaudio feh wget unzip nautilus htop adobe-source-code-pro-fonts noto-fonts-cjk acpi libreoffice sddm alsa alsa-utils

systemctl enable sddm

rm -rf /home/$userName/.Wallpapers
mkdir /home/$userName/.Wallpapers
cp rcs/wallpaper/Wallpaper.png /home/$userName/.Wallpapers

rm -rf /home/$userName/.Xresources
cp rcs/xresources/.Xresources /home/$userName/.Xresources

mkdir /home/$userName/.config/
mkdir /home/$userName/.config/i3
cp rcs/i3/config /home/$userName/.config/i3

rm -rf /home/$userName/.config/compton.conf
cp rcs/compton/compton.conf /home/$userName/.config/compton.conf

rm -rf /home/$userName/.i3blocks.conf
cp rcs/i3blocks/.i3blocks.conf /home/$userName/.i3blocks.conf

clear

fi

## installs kde plasma

if [ $deChoice -eq 2 ]; then

pacman -S --noconfirm bash-completion vim wpa_supplicant intel-ucode grub xorg xorg-xinit firefox vlc xf86-video-intel thunderbird pulseaudio wget unzip htop adobe-source-code-pro-fonts noto-fonts-cjk acpi libreoffice sddm alsa alsa-utils plasma kde-applications

systemctl enable sddm
systemctl disable dhcpcd
systemctl enable NetworkManager

rm -rf /usr/lib/sddm/sddm.conf.d/default.conf
cp configs/sddm/default.conf /usr/lib/sddm/sddm.conf.d/default.conf

clear

fi

## installs kde plasma (without kde-applications)

if [ $deChoice -eq 3 ]; then

pacman -S --noconfirm bash-completion vim wpa_supplicant intel-ucode grub xorg xorg-xinit firefox vlc xf86-video-intel thunderbird pulseaudio wget unzip htop adobe-source-code-pro-fonts noto-fonts-cjk acpi libreoffice sddm alsa alsa-utils plasma 

systemctl enable sddm
systemctl disable dhcpcd
systemctl enable NetworkManager

rm -rf /usr/lib/sddm/sddm.conf.d/default.conf
cp configs/sddm/default.conf /usr/lib/sddm/sddm.conf.d/default.conf

clear

fi

## installs kde plasma minimal

if [ $deChoice -eq 4 ]; then

pacman -S --noconfirm bash-completion vim wpa_supplicant intel-ucode grub xorg xorg-xinit firefox vlc xf86-video-intel thunderbird pulseaudio wget unzip htop adobe-source-code-pro-fonts noto-fonts-cjk acpi libreoffice sddm alsa alsa-utils plasma-desktop 

systemctl enable sddm
systemctl disable dhcpcd
systemctl enable NetworkManager

rm -rf /usr/lib/sddm/sddm.conf.d/default.conf
cp configs/sddm/default.conf /usr/lib/sddm/sddm.conf.d/default.conf

clear

fi

## installs gnome

if [ $deChoice -eq 5 ]; then

pacman -S --noconfirm bash-completion vim wpa_supplicant intel-ucode grub xorg xorg-xinit firefox vlc xf86-video-intel thunderbird pulseaudio wget unzip htop adobe-source-code-pro-fonts noto-fonts-cjk acpi libreoffice sddm alsa alsa-utils gnome gnome-extra gdm 

systemctl enable gdm
systemctl disable dhcpcd
systemctl enable NetworkManager

clear

fi

## installs gnome without gnome-extra

if [ $deChoice -eq 6 ]; then

pacman -S --noconfirm bash-completion vim wpa_supplicant intel-ucode grub xorg xorg-xinit firefox vlc xf86-video-intel thunderbird pulseaudio wget unzip htop adobe-source-code-pro-fonts noto-fonts-cjk acpi libreoffice sddm alsa alsa-utils gnome gdm 

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

rm -rf /home/$userName/.bashrc
cp rcs/bashrc/.bashrc /home/$userName/.bashrc

rm -rf /home/$userName/.bash_profile
cp configs/bash_profile/.bash_profile /home/$userName/.bash_profile

rm -rf /home/$userName/.gtkrc-2.0
cp rcs/gtk-2.0/.gtkrc-2.0 /home/$userName/.gtkrc-2.0

rm -rf /home/$userName/.config/gtk-3.0
mkdir /home/$userName/.config/gtk-3.0
cp rcs/gtk-3.0/settings.ini /home/$userName/.config/gtk-3.0

chown -hR $userName /home/$userName/

clear

## Installs and configures GRUB

printf "Installing GRUB\n\n"

rm -rf /etc/default/grub
cp configs/grub/grub /etc/default/grub
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

clear

## deletes the repository

rm -rf /$repoName/

printf "The system installation is done, you can run yaourt.sh to install yaourt or reboot your system now\n\n"

su $userName
