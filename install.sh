printf "Domainserver name?\n\n"
read domainServer

printf "Now lets create a password for root\n\n"

printf "Password for root:\n"
passwd

printf "And lets add a user, with the name...\nuser: "
read userName

useradd -m -g wheel $userName
passwd $userName

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

printf "$domainserver" > /etc/hostname
printf "127.0.0.1\tlocalhost\n::1\tlocalhost\n127.0.1.1\t$domainserver.localdomain\t$domainserver" > /etc/hosts

clear

printf "Go and make yourself a coffe, this is going to take time."

printf "Creating initframs.\n\n"

mkinitcpio -p linux

printf "Downloading stuff.\n\n"

pacman -Syu --noconfirm bash-completion vim dialog wpa_supplicant intel-ucode grub i3 dmenu xorg xorg-xinit firefox vlc rxvt-unicode elinks xf86-video-intel thunderbird compton pulseaudio feh wget unzip nautilus htop cmus
