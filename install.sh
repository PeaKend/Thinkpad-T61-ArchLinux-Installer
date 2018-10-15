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

pacman -S --noconfirm vim dialog wpa_supplicant intel-ucode grub i3 dmenu xorg xorg-xinit firefox vlc rxvt-unicode elinks xf86-video-intel thunderbird compton pulseaudio feh wget unzip nautilus htop cmus adobe-source-code-pro-fonts noto-fonts-cjk acpi libreoffice sddm breeze alsa alsa-utils

systemctl enable sddm

rm -rf /usr/lib/sddm/sddm.conf.d/default.conf
cp configs/sddm/default.conf /usr/lib/sddm/sddm.conf.d/default.conf

clear

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
cp config /home/$userName/.config/i3

rm -rf /home/$userName/.i3blocks.conf
cp rcs/i3blocks/.i3blocks.conf /home/$userName/.i3blocks.conf

rm -rf /home/$userName/.gtkrc-2.0
cp rcs/gtk-2.0/.gtkrc-2.0 /home/$userName/.gtkrc-2.0

rm -rf /home/$userName/.config/gtk-3.0
mkdir /home/$userName/.config/gtk-3.0
cp configs/rcs/gtk-3.0/settings.ini /home/$userName/.config/gtk-3.0

rm -rf /home/$userName/.config/compton.conf
cp rcs/compton/compton.conf /home/$userName/.config/compton.conf

rm -rf /home/$userName/.i3blocks.conf
cp .i3blocks.conf /home/$userName/.i3blocks.conf

mkdir /home/$userName/.tmp

chown -hR $userName /home/$userName/

## Installs and configures GRUB

printf "Installing GRUB\n\n"

rm -rf /etc/default/grub
cp configs/grub/grub /etc/default/grub
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

## Installs yaourt

printf "Installing yaourt\n\n"

su $userName
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..
rm -rf package-query
rm -rf yaourt
