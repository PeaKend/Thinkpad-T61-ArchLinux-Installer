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

printf "How will be your hostname name?\n\n"
read domainServer

printf "Making configurations.\n\n"

printf "$domainserver" > /etc/hostname
printf "127.0.0.1\tlocalhost\n::1\tlocalhost\n127.0.1.1\t$domainserver.localdomain\t$domainserver" > /etc/hosts

printf "Creating initframs.\n\n"

mkinitcpio -p linux

printf "Now lets create a password for root\n\n"

printf "Password for root:\n"
passwd

printf "And lets add a user, with the name...\n\n"
read userName

useradd -m -g wheel $userName
passwd $userName

