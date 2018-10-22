## My Thinkpad T61 Installer Script

Tired of manually installing Arch Linux on your laptop?

I Made a script for that!

### This script does the following

#### pre-install.sh

* Looks for your internet connection.
* Sets ntp timedatectl service.
* Wipe your entire /dev/sda disk.
* Formats /dev/sda to GPT partition.
* Writes a 1MB ef02 (BIOS boot partition) GPT partition to /dev/sda1.
* Writes a 8GB 8200 (SWAP partition) GPT partition to /dev/sda2.
* Writes the rest of the disk as 8300 (Linux Filesystem) GPT partition to /dev/sda3.
* Formats /dev/sda2 to swap.
* Mounts /dev/sda2 with swapon.
* Formats /dev/sda3 to ext4.
* Mounts /dev/sda3 to /mnt.
* Installs base and base-devel to /mnt (/dev/sda3).
* Generates the fstab file.
* Chroots to the new system.

#### install.sh

* Asks for your domainserver name.
* Asks for your new root password.
* Asks and creates a new user.
* Asks for the new user password.
* Adds the new user to sudoers.
* Asks for a DE or WM to install.
* Links the localtime to America/Argentina/Buenos_Aires.
* Sets hardware clock.
* Generates a locale-gen of en_US.utf-8.
* Sets the language to english.
* It configures pacman to show total download percentage.
* Configures your domainserver file.
* Configures your hosts file.
* Creates a new initramfs (just in case).
* Downloads packages.
* Clones https://github.com/supermarin/YosemiteSanFranciscoFont font.
* Installs the new font.
* Installs my rc files.
* Copies a CC Licenced wallpaper.
* Installs GRUB at /dev/sda.
* Makes the GRUB configuration file at /mnt/boot/grub/grub.cfg.
* Configures GRUB to boot instantly.

#### installYaourt.sh

* Installs package-query (requeriment for yaourt).
* Installs yaourt.
* Configures yaourt to ignore confirmations.

### The install script includes the following packages

* bash-completion
* vim
* intel-ucode
* grub
* i3
* dmenu
* xorg
* xorg-xinit
* firefox
* vlc
* rxvt-unicode
* elinks
* xf86-video-intel
* thunderbird
* compton
* pulseaudio
* feh
* wget
* unzip
* nautilus
* htop
* adobe-source-code-pro-fonts
* noto-fonts-cjk
* acpi
* libreoffice
* alsa
* alsa-utils

### Extra packages for DE/WM:

#### i3

* i3
* dmenu
* rxvt-unicode
* sddm
* wpa_supplicant
* dialog
* feh
* nautilus

#### KDE Plasma

* plasma
* kde-applications
* sddm

#### Gnome

* gnome
* gnome-extra
* gdm

### End result (i3)

![neofetch of the system created by the script](https://i.imgur.com/wSPUFdf.png)
