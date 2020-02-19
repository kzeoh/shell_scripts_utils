#!/bin/bash
filepath=/home/kwonje/lock/4containers/
#size=$1
rw=20

for p in 1 2 3 4 5
do
	free -m
	sync
	echo 3 > /proc/sys/vm/drop_caches
	free -m
	echo 0 > /proc/lock_stat
	echo 1 > /proc/sys/kernel/lock_stat
	
	for weight in 100 200 400 800
	do
	#	docker run -i --rm --blkio-weight=${weight} -v /volume/workloads/:/mnt --entrypoint="filebench" keinoh/journal:1.5  -f /mnt/fileserver-new.f &
		docker run -i --rm --blkio-weight=${weight} -v /volume/workloads/:/mnt --entrypoint="fio" keinoh/journal:1.5  /mnt/jobfile1 &
	#docker run -i --rm --entrypoint="filebench" keinoh/journal:1.4  -f /home/filebench/workloads/fileserver-new-200k.f &
done
	wait
	echo 0 > /proc/sys/kernel/lock_stat
	cp /proc/lock_stat ${filepath}${p}.txt
	cat ${filepath}${p}.txt | grep "zone->lock" >> ${filepath}fio-${rw}.txt
	#rm ${filepath}${p}.txt
done


