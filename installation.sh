#!/bin/bash

pacstrap /mnt base base-devel linux linux-firmware vim man info man-db map-pages texinfo

genfstab -U /mnt > /mnt/etc/fstab

GENERATED_FSTAB=$(cat /mnt/etc/fstab >/dev/null && echo 1 || echo 0)

if [ $GENERATED_FSTAB -eq 0 ]
then
	echo "fstab não gerado. Saindo poer segurança"
	exit
fi
