#!/bin/bash
echo "type mount journal mode"
read j_mode

systemctl stop docker
#service docker stop
umount -v /dev/sdb1
mkfs -t ext4 /dev/sdb1

if [ $j_mode == "no" ]
then
	dumpe2fs /dev/sdb1 | head -n 10
	tune2fs -O ^has_journal /dev/sdb1
	fsck.ext4 -f /dev/sdb1
	dumpe2fs /dev/sdb1 | head -n 10
	mount /dev/sdb1 /mnt 
else
	dumpe2fs /dev/sdb1 | head -n 10
	mount /dev/sdb1 /mnt -t ext4 -o data=$j_mode
fi
systemctl start docker
#service docker start
echo "container ver is"
read ver
docker pull keinoh/journal:1.$ver


