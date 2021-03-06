#!/bin/bash
filepath=/home/kwonje/lock/4containers/
size=30
time=60sec

for p in 1
do
	systemctl stop docker
	umount /mnt
	mkfs.ext4 /dev/sdb1
	mount -t ext4 /dev/sdb1 /mnt
	fstrim /mnt -v

	systemctl start docker

	docker pull keinoh/journal:1.5

	free -m
	sync
	echo 3 > /proc/sys/vm/drop_caches
	free -m
#	echo 0 > /proc/lock_stat
#	echo 1 > /proc/sys/kernel/lock_stat
	
	#	docker run -i --rm --blkio-weight=${weight} -v /volume/workloads/:/mnt --entrypoint="filebench" keinoh/journal:1.5  -f /mnt/fileserver-new.f &
		docker run -i --rm --blkio-weight=100 --memory=1024m -v /home/kwonje/mount/:/mnt --entrypoint="filebench" keinoh/journal:1.5  -f /mnt/workloads/fileserver-new.f &
		docker run -i --rm --blkio-weight=200 --memory=2048m -v /home/kwonje/mount/:/mnt --entrypoint="filebench" keinoh/journal:1.5  -f /mnt/workloads/fileserver-new.f &
		docker run -i --rm --blkio-weight=400 --memory=4096m -v /home/kwonje/mount/:/mnt --entrypoint="filebench" keinoh/journal:1.5  -f /mnt/workloads/fileserver-new.f &
		docker run -i --rm --blkio-weight=800 --memory=8192m -v /home/kwonje/mount/:/mnt --entrypoint="filebench" keinoh/journal:1.5  -f /mnt/workloads/fileserver-new.f &
#docker run -i --rm --entrypoint="filebench" keinoh/journal:1.4  -f /home/filebench/workloads/fileserver-new-200k.f &
	wait
#	echo 0 > /proc/sys/kernel/lock_stat
#	cp /proc/lock_stat ${filepath}${p}_file.txt
#	cat ${filepath}${p}_file.txt | grep "zone->lock" >> ${filepath}result_${size}_${time}_original.txt
#	rm ${filepath}${p}_file.txt
done


