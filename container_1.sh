#!/bin/bash
filepath=/home/kwonje/lock/1container/
size=$1
time=100sec

for p in 1  
do
	free -m
	sync
	echo 3 > /proc/sys/vm/drop_caches
	free -m
	echo 0 > /proc/lock_stat
	echo 1 > /proc/sys/kernel/lock_stat
	docker run -i --rm --blkio-weight=100 -v /volume/workloads/:/mnt --entrypoint="filebench" keinoh/journal:1.5 -f /mnt/fileserver-new.f
	echo 0 > /proc/sys/kernel/lock_stat
	#cat ${filepath}${p}.txt | grep "Summary" >> ${filepath}throughput_${size}_${time}.txt
	cp /proc/lock_stat ${filepath}${p}.txt
	cat ${filepath}${p}.txt | grep "zone->lock" >> ${filepath}result_${size}_${time}.txt
	rm ${filepath}${p}.txt
done


