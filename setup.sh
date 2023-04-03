#!/usr/bin/env bash
#-------------------------------------------------------------------------
#   █████╗ ██████╗  ██████╗██╗  ██╗████████╗██╗████████╗██╗   ██╗███████╗
#  ██╔══██╗██╔══██╗██╔════╝██║  ██║╚══██╔══╝██║╚══██╔══╝██║   ██║██╔════╝
#  ███████║██████╔╝██║     ███████║   ██║   ██║   ██║   ██║   ██║███████╗
#  ██╔══██║██╔══██╗██║     ██╔══██║   ██║   ██║   ██║   ██║   ██║╚════██║
#  ██║  ██║██║  ██║╚██████╗██║  ██║   ██║   ██║   ██║   ╚██████╔╝███████║
#  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝   ╚═╝    ╚═════╝ ╚══════╝
#-------------------------------------------------------------------------


echo "
###############################################################################
# Configuring Best Mirrors & Setting up repos
###############################################################################
"
sudo reflector -a 48 -c SE -f 5 -l 20 --sort rate --save /etc/pacman.d/mirrorlist


echo "
###############################################################################
# Installing essential software
###############################################################################
"


PKGS=(
'imagemagick'
'w3m'
'rxvt-unicode-truecolor-wide-glyphs'

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --needed --overwrite '*'
done


echo "
###############################################################################
# MISC CONFIG
###############################################################################
"
sleep 2
cd ~
mkdir ~/build
cp ~/lulz/build.sh ~/build/
cd ~



xrdb ~/.Xresources

sudo modprobe -r k10temp
sudo bash -c 'sudo echo -e "\n# replaced with zenpower\nblacklist k10temp" >> /etc/modprobe.d/blacklist.conf'
sudo modprobe zenpower


sudo ln -sf /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
sudo ln -sf /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
sudo ln -sf /etc/fonts/conf.avail/10-hinting-full.conf /etc/fonts/conf.d
sudo sed "s,\#export FREETYPE_PROPERTIES=\"truetype\:interpreter-version=40\",export FREETYPE_PROPERTIES=\"truetype\:interpreter-version=40\",g" -i /etc/profile.d/freetype2.sh

sudo grub-mkconfig -o /boot/grub/grub.cfg


echo "
###############################################################################
# Done
###############################################################################
"
sleep 3
