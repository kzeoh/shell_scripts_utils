#!/bin/bash
#for size in 10k
#do
	for n in 8 
	do
		systemctl stop docker
		#service docker stop
		umount -v /dev/sdb1
		mkfs -t ext4 /dev/sdb1
		dumpe2fs /dev/sdb1 | head -n 10
		mount /dev/sdb1 /mnt -t ext4 -o data=ordered
		systemctl start docker
		docker pull keinoh/journal:1.5
		./container_${n}.sh
	done
#done

