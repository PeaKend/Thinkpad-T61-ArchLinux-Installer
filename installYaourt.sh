#!/bin/bash

if [[ $EUID -eq 0 ]]; then
	echo "you need to run this script as the user"
	exit 1
fi

cd ~/

## Installs yaourt

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
sudo rm -rf /etc/yaourtrc && sudo cp configs/yaourt/yaourtrc /etc/yaourtrc
