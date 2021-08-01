DIRNAME=$(dirname $0)

loadedPackages=$(cat $DIRNAME/packages >/dev/null && echo 1 || echo 0)

if [ $loadedPackages = "1" ]
then	
	packages=$(cat $DIRNAME/packages)
	pacman -Syu
	pacman -S $packages

	echo "Instalar inicializador(GRUB)[s/n]?"
	read install_grub

	if [ $install_grub = "s" ]
	then
		EFI_MODE=$(ls /sys/firmware/efi/efivars >/dev/null && echo 1 || echo 0)
		if [ $EFI_MODE -eq 1 ]
		then
			pacman -S grub-efi-x86_64 efibootmgr
			grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
			cp /usr/share/locale/en@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
		else
			pacman -S grub
			grub-install --target=i386-pc --recheck /dev/sda
		fi

		grub-mkconfig -o /boot/grub/grub.cfg
	fi

	$DIRNAME/base-configurations.sh

	systemctl enable NetworkManager

	echo "Finalizado"
else
	echo "Não foi possível achar o arquivo packages. Saindo por segurança"
fi
