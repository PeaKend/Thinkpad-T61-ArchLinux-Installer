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
cp /configs/locale/locale.gen /etc/locale.gen
locale-gen

printf "Setting language to english\n\n"

rm -rf /etc/locale.conf
cp /configs/locale/locale.conf /etc/locale.conf

printf "Making configurations\n\n"

rm -rf /etc/pacman.conf
cp pacman.conf /etc/pacman.conf
rm -rf /etc/pacman.d/mirrorlist
cp mirrorlist /etc/pacman.d/mirrorlist

printf "\n127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t$domainServer.localdomain\t$domainServer" >> /etc/hosts

clear

## Downloads programs

printf "Go and make yourself a coffe, this is going to take a while\n\n"

printf "Downloading stuff\n\n"

pacman -S --noconfirm bash-completion vim dialog wpa_supplicant intel-ucode grub i3 dmenu xorg xorg-xinit firefox vlc rxvt-unicode elinks xf86-video-intel thunderbird compton pulseaudio feh wget unzip nautilus htop cmus adobe-source-code-pro-fonts noto-fonts-cjk acpi libreoffice sddm

systemctl enable sddm
sed -i '/Current=/ s/$/breeze/' /usr/lib/sddm/sddm.conf.d/default.conf

clear

## Installs yaourt

printf "Installing yaourt\n\n"

git clone https://aur.archlinux.org/package-query.git
cd package-query
su $userName makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
su $userName makepkg -si
cd ..
rm -rf package-query
rm -rf yaourt
rm -rf /etc/yaourtrc
cp yaourtrc /etc/yaourtrc

## Installs rcs

printf "Cloning and installing Yosemite San Francisco Font\n\n"

git clone https://github.com/supermarin/YosemiteSanFranciscoFont
cd YosemiteSanFranciscoFont/
mkdir /home/$userName/.fonts
cp *.ttf /home/$userName/.fonts
cd ..
rm -rf YosemiteSanFranciscoFont

printf "Installing rcs\n\n"

rm -rf /home/$userName/.Wallpapers
mkdir /home/$userName/.Wallpapers
cp Wallpaper1.png /home/$userName/.Wallpapers

rm -rf /home/$userName/.bashrc
cp .bashrc /home/$userName/.bashrc

rm -rf /home/$userName/.bash_profile
cp .bash_profile /home/$userName/.bash_profile

rm -rf /home/$userName/.Xresources
cp .Xresources /home/$userName/.Xresources

mkdir /home/$userName/.config/
mkdir /home/$userName/.config/i3
cp config /home/$userName/.config/i3

rm -rf /home/$userName/.i3blocks.conf
cp .i3blocks.conf /home/$userName/.i3blocks.conf

rm -rf /home/$userName/.gtkrc-2.0
cp .gtkrc-2.0 /home/$userName/.gtkrc-2.0

rm -rf /home/$userName/.config/gtk-3.0
mkdir /home/$userName/.config/gtk-3.0
cp settings.ini /home/$userName/.config/gtk-3.0

rm -rf /home/$userName/.config/compton.conf
cp compton.conf /home/$userName/.config/compton.conf

rm -rf /home/$userName/.i3blocks.conf
cp .i3blocks.conf /home/$userName/.i3blocks.conf

## Installs and configures GRUB

printf "Installing GRUB\n\n"

rm -rf /etc/default/grub
cp grub /etc/default/grub
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
