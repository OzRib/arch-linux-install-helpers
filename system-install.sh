DIRNAME=$(dirname $0)

loadedPackages=$(cat $DIRNAME/packages >/dev/null && echo 1 || echo 0)

if [ $loadedPackages = "1" ]
then	
	packages=($(cat packages))
	pacman -Syu
	pacman -S $packages

	$DIRNAME/base-configurations.sh

	systemctl enable NetworkManager
	systemctl enable lightdm

	echo "Finalizado"
else
	echo "Não foi possível achar o arquivo packages. Saindo por segurança"
fi
