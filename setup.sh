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
sudo pacman -S reflector rsync

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
'nm-connection-editor'
'networkmanager'
'grub-customizer'
'gparted'
'lzop'
'lz4'
'mimalloc'
'cpio'
'unzip'
'p7zip'
'geany'
'geany-plugins'
'qogir-icon-theme'
'neofetch'
'firefox'
'kitty'
'linux-tools'
'yay'
'paru'

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --needed --noconfirm --overwrite '*'
done


mkdir ~/clang
cd ~/clang
wget https://github.com/Mandi-Sa/clang/releases/download/amd64-full-toolchain-20/llvm20.0.0-binutils2.42_amd64-full-toolchain-20241001.7z
7z x amd64-full-toolchain*

echo "
###############################################################################
# MISC CONFIG
###############################################################################
"
sleep 2

cd ~/lulleman/cachyos-repo/
sudo ./cachyos-repo.sh

sudo bash -c 'cat << EOF >> /etc/pacman.conf
[chaotic-aur]
Server = https://random-mirror.chaotic.cx/\$repo/\$arch
SigLevel = Never
#wailord284 custom repo with many aur packages used by Alex's Arch Linux Installer
[aurmageddon]
Server = https://wailord284.club/repo/\$repo/\$arch
SigLevel = Never
EOF'


xrdb ~/.Xresources


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
