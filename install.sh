printf "Domainserver name?\n\n"
read domainServer

printf "Now lets create a password for root\n\n"

printf "Password for root:\n"
passwd

printf "And lets add a user, with the name...\nuser: "
read userName

useradd -m -g wheel $userName
passwd $userName
printf "\n$userName ALL=(ALL) ALL" >> /etc/sudoers

printf "Setting timezone (Argentina)\n\n"

ln -sf /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime

printf "Running hwclock().\n\n"

hwclock --systohc

printf "Configuring locale.gen.\n\n"

rm -rf /etc/locale.gen 
mv locale.gen /etc/locale.gen
locale-gen

printf "Setting language to english.\n\n"

rm -rf /etc/locale.conf
mv locale.conf /etc/locale.conf

printf "Making configurations.\n\n"

rm -rf /etc/pacman.conf
mv pacman.conf /etc/pacman.conf
rm -rf /etc/pacman.d/mirrorlist
mv mirrorlist /etc/pacman.d/mirrorlist

printf "$domainserver" > /etc/hostname
printf "127.0.0.1\tlocalhost\n::1\tlocalhost\n127.0.1.1\t$domainserver.localdomain\t$domainserver" > /etc/hosts

clear

printf "Go and make yourself a coffe, this is going to take a lot of time.\n\n"

printf "Creating initframs.\n\n"

mkinitcpio -p linux

printf "Downloading stuff.\n\n"

pacman -Syu --noconfirm bash-completion vim dialog wpa_supplicant intel-ucode grub i3 dmenu xorg xorg-xinit firefox vlc rxvt-unicode elinks xf86-video-intel thunderbird compton pulseaudio feh wget unzip nautilus htop cmus adobe-source-code-pro-fonts noto-fonts-cjk

clear

printf "Installing yaourt.\n\n"

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
mv yaourtrc /etc/yaourtrc

printf "Cloning and installing Yosemite San Francisco Font\n\n"
git clone https://github.com/supermarin/YosemiteSanFranciscoFont

cd YosemiteSanFranciscoFont/
su $userName mv *.ttf ~/.fonts
cd ..
rm -rf YosemiteSanFranciscoFont

printf "Installing rcs.\n\n"

su $userName rm -rf ~/.xinitrc
su $userName mv .xinitrc ~/.xinitrc

su $userName rm -rf ~/.bashrc
su $userName mv .bashrc ~/.bashrc

su $userName rm -rf ~/.bash_profile
su $userName mv .bash_profile ~/.bash_profile

su $userName rm -rf ~/.Xresources
su $userName mv .Xresources ~/.Xresources

su $userName mkdir ~/.config/
su $userName mkdir ~/.config/i3
su $userName mv config ~/.config/i3

su $userName rm -rf ~/.i3blocks.conf
su $userName mv .i3blocks.conf ~/.i3blocks.conf

su $userName rm -rf ~/.gtkrc-2.0
su $userName mv .gtkrc-2.0 ~/.gtkrc-2.0

su $userName rm -rf ~/.config/gtk-3.0
su $userName mkdir ~/.config/gtk-3.0
su $userName mv settings.ini ~/.config/gtk-3.0

su $userName rm -rf ~/.config/compton.conf
su $userName cp compton.conf ~/.config/compton.conf

printf "Installing GRUB\n\n"

grub-install --target=i386-pc /dev/sda
rm -rf /etc/default/grub
mv grub /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
