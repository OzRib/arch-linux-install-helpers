#!/bin/bash

pacstrap -i /mnt base base-devel linux linux-firmware vim man man-db man-pages texinfo

genfstab -U /mnt > /mnt/etc/fstab

GENERATED_FSTAB=$(cat /mnt/etc/fstab >/dev/null && echo 1 || echo 0)

if [ $GENERATED_FSTAB -eq 0 ]
then
	echo "fstab não gerado. Saindo poer segurança"
	exit
fi

arch-chroot /mnt

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
ff02::2	ip6-allrouters" > /etc/hosts

echo "Nova senha para root:"
passwd
