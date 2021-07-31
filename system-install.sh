DIRNAME=$(dirname $0)

loadedPackages=$(cat $DIRNAME/packages >/dev/null && echo 1 || echo 0)

if [ $loadedPackages = "1" ]
then	
	packages=($(cat packages))
	pacman -Syu
	pacman -S $packages

	systemctl enable NetworkManager
	systemctl enable lightdm

	pacman -S git
	rm -rf /tmp/pamac-install
	git clone https://aur.archlinux.org/pamac-aur.git /tmp/pamac-install
	makepkg -sic BUILDDIR=/tmp/pamac-install

	echo "Finalizado"
else
	echo "Não foi possível achar o arquivo packages. Saindo por segurança"
fi
