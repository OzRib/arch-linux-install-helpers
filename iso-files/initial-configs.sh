#!/bin/bash

loadkeys br-abnt2

echo 'pt_BR.UTF-8 UTF-8' > /etc/locale.gen
locale-gen
export LANG=pt_BR.UTF-8

device_cmd=($(iwctl device list))
device=${device_cmd[11]}

device_state=($(iwctl station $device show))
connected=$([ ${device_state[13]} = "connected" ] && echo 1 || echo 0)

if [ $connected -eq 0 ]
then	
	echo "Conectar a rede WiFi [s/n]?"
	read connect_confirmation

	connect=$([ $connect_confirmation = "s" ] && echo 1 || echo 0)
else
	connect=$(echo 0)
fi

if [ $connect -eq 1 ]
then
	try_connect=1
	
	while [ $try_connect -eq 1 ]
	do
		iwctl station $device scan
		iwctl station $device get-networks
	
		echo "Nome da rede:"
		read network_name

		success_connection=$(iwctl station $device connect "$network_name" >/dev/null && echo 0 || echo 1)

		if [ $success_connection -eq 1 ]
		then
			echo "Erro ao conectar"
			echo "Tentar conectar novamente [s/n]?"
			read repeat

			try_connect=$([ $repeat = "s" ] && echo 1 || echo 0)
		else
			try_connect=0
		fi
	done
fi

timedatectl set-ntp true

echo "Okay... Continue com o particionamento manualmente"

EFI_MODE=$(ls /sys/firmware/efi/efivars >/dev/null && echo "UEFI" || echo "BOOT")
echo "Dica modo $EFI_MODE"
