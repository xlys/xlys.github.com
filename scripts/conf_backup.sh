#! /usr/bin/env bash

# META

# This script does:
# Backup all configs manually deemed important on my linux partitions. 
# Backup a list of manually installed apps according to pacman.
# Backup all dotfiles in my home folder, and their subdirectories. (pretty messy, but comprehensive and more future proof.)

# This script does NOT:
# Backup anything from my windows partitions.

# FUNCTIONALITY

# Input user name here in place of "lys":
username=lys

# Generated from the user name to simplify paths:
userdir=home/$username

# Make folder of current date in "Year-Month-Day" format, for current backup.
mkdir `date '+%Y-%m-%d'`
# Descend into that directory.
cd `date '+%Y-%m-%d'`
# Make the folder conf inside the date folder.
mkdir lnx_conf
# Descend into that directory.
cd lnx_conf

# Make subdirectories.
mkdir etc
  mkdir etc/default
  mkdir etc/grub.d
  mkdir etc/udev
    mkdir etc/udev/rules.d
  mkdir etc/X11
    mkdir etc/X11/xinit
mkdir home
  mkdir home/$username
#  mkdir $userdir/dotfile_madness    - crazy space consuming, and lots of junk.
mkdir usr
  mkdir usr/local
# mkdir usr/local/bin
  mkdir usr/share
	mkdir usr/share/kbd
	  mkdir usr/share/kbd/keymaps
	    mkdir usr/share/kbd/keymaps/i386
	      mkdir usr/share/kbd/keymaps/i386/qwerty

# Copy files into those directories.

# Backup itself first, before it is populated by the backup.
cp -r /$userdir/sh/ $userdir/

# /etc
cp /etc/bash.bashrc etc/
cp /etc/fstab etc/
cp /etc/profile etc/
cp /etc/rc.conf etc/
#cp /etc/slim.conf etc/
cp /etc/vimrc etc/
cp /etc/pacman.conf etc/
#cp /etc/wpa_supplicant_lys.conf etc/ - cannot backup because it requires sudo because I've set it to because it contains sensitive information.

# /etc/
cp -r /etc/ifplugd/ etc/
cp /etc/X11/xinit/xinitrc etc/X11/xinit

# /etc/default
cp /etc/default/grub etc/default

# /etc/grub.d
cp /etc/grub.d/40_custom etc/grub.d/

# /etc/udev/rules.d
cp /etc/udev/rules.d/* etc/udev/rules.d/

# /usr/local/bin
#cp -r /usr/local/bin/* usr/local/bin/

# /usr/share
cp -r /usr/share/awesome/ usr/share/
cp -r /usr/share/kbd/keymaps/i386/qwerty/mydk-latin1.map.gz usr/share/kbd/keymaps/i386/qwerty/
cp /usr/share/vim/vim74/colors/molokai_miyalys.vim /usr/share/   # Not entirely the right directory, but whatever.

# /home - copy all dotfiles and folders.
#cp -r /$userdir/.[a-zA-Z0-9]* $userdir/dotfile_madness/

# /home
cp -r /$userdir/bin/ $userdir/
cp -r /$userdir/.config/ $userdir/
cp -r /$userdir/.asoundrc /$userdir/.bashrc /$userdir/.pentadactylrc /$userdir/.ssh /$userdir/.thunderbird/ /$userdir/.vim/ /$userdir/.vimrc /$userdir/.Xresources $userdir/
cp /$userdir/.gitconfig /$userdir/.gitignore /$userdir/.gitignore_global $userdir/

# END OF FILE BACKUPS

# Create a file with a list of all installed packages except for base and devel. It may include packages that were installed from foreign packages (AUR fx.) not from Core, Extra or Community. 
comm -23 <(pacman -Qeq) <(pacman -Qgq base base-devel | sort ) > home/$username/pkg_list.txt
