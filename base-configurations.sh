#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Fortaleza /etc/localtime
hwclock --systohc

echo 'pt_BR.UTF-8 UTF-8' > /etc/locale.gen
locale-gen

touch /etc/locale.conf
echo 'LANG=pt_BR.UTF-8' > /etc/locale.conf

touch /etc/vconsole.conf
echo 'KEYMAP=br-abnt2' > /etc/vconsole.conf

echo 'Nome do PC na rede:'
read hostname

touch /etc/hostname
echo "$hostname" > /etc/hostname

touch /etc/hosts
echo "127.0.0.1	localhost
127.0.1.1	$hostname
::1	localhost ip6-localhost ip6-loopback
ff02::1	ip6-allnodes
ff02::2	ip5-allrouters" > /etc/hosts

echo "Nova senha para root:"
passwd

echo "Novo usuário:"
read user
useradd -m -g users -G wheel $user

echo "Senha para $user:"
passwd $user

pacman -S git
rm -rf /tmp/pamac-install
git clone https://aur.archlinux.org/pamac-aur.git /tmp/pamac-install
su - $user -c makepkg -sic BULDDIR=/tmp/pamac-install
