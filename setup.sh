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
sudo pacman -S reflector rsync --noconfirm

sudo reflector -a 48 -c SE -f 5 -l 20 --sort rate --save /etc/pacman.d/mirrorlist


echo "
###############################################################################
# Installing essential software
###############################################################################
"


PKGS=(
'imagemagick'
'w3m'
'gparted'
'lzop'
'lz4'
'mimalloc'
'cpio'
'unzip'
'p7zip'
'neofetch'
'linux-tools'
'yay'
'paru'
'bc'
'bison'
'flex'
'ccache'
'cmake'
'extra-cmake-modules'
'ninja'
'meson'
'musl'
'mesa-tkg-git'
'boost'
'boost-libs'
'gperftools'
'python-setuptools'
'git'
'wget'
'curl'
'zsh'
'zsh-completions'

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --needed --noconfirm --overwrite '*'
done


mkdir ~/clang
cd ~/clang
wget https://github.com/Mandi-Sa/clang/releases/download/amd64-full-toolchain-21/llvm21.0.0-binutils2.44_amd64-full-toolchain-20250702.7z
7z x *llvm*
rm llvm21*

echo "
###############################################################################
# MISC CONFIG
###############################################################################
"
sleep 2

sudo bash -c 'cat << EOF >> /etc/pacman.conf
[chaotic-aur]
Server = https://random-mirror.chaotic.cx/\$repo/\$arch
SigLevel = Never
[aurmageddon]
Server = https://wailord284.club/repo/\$repo/\$arch
SigLevel = Never
EOF'

sudo pacman -Sy
sudo pacman -S chaotic-mirrorlist --noconfirm

cd /home/lulle/lulleman/home/
cp -rf . /home/lulle/
cd /home/lulle/lulleman/etc
sudo cp -rf * /etc/
cd /home/lulle/lulleman/share
sudo cp -rf fonts /usr/share/

sudo sed "s,\#\ %wheel ALL=(ALL:ALL) ALL,%wheel ALL=(ALL:ALL) ALL,g" -i /etc/sudoers


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
