#!/bin/bash
#kwonje making cgroup hierarchy
mountdir="/home/kwonje/mount"
dir="/sys/fs/cgroup"

#echo "type mount journal mode"
#read j_mode

echo cfq > /sys/block/sdc/queue/scheduler
#echo 1 > /sys/block/nvme0n1/queue/iosched/strict_guarantees
#echo 0 > /sys/block/nvme0n1/queue/iosched/low_latency
#echo 1 > /sys/block/sdc/queue/iosched/strict_guarantees
#echo 0 > /sys/block/sdc/queue/iosched/low_latency

echo "create new?"
read new
echo $new
if [ "$new" == "y" ]; then
	for ((i=2;i<=2;i++))
	do	
		find /sys/fs/cgroup/group${i}/ | grep "cgroup.procs" > temp
		input="./temp"
		while read line;
		do
			pid="$(cat ${line})"
			echo="$pid"
			echo $pid > ${dir}/cgroup.procs
		done < "$input"	
	done
	rmdir  $dir/group*/group*/group* $dir/group*/group* $dir/group*
	umount /cgroup2
	rmdir /cgroup2
	#rm -rf $mount/
	echo "mount sdc?"
	read dev
	if [ "$dev" == "y" ]; then
		umount $mountdir
		#umount -v /dev/sdc1
		./del_cache.sh
		#fdisk /dev/nvme0n1
		#fdisk /dev/nvme0n1
		mkfs -t ext4 /dev/sdc1
		#mkfs -t ext4 /dev/nvme0n1p1
	#	dumpe2fs /dev/sdc1 | head -n 10
#		mount /dev/nvme0n1p1 ${mountdir} -t ext4 -o data=ordered
		mount /dev/sdc1 ${mountdir} -t ext4 -o data=ordered
		./del_cache.sh
		fstrim ${mountdir} -v
	
	fi
	mkdir /cgroup2
	mount -t cgroup2 none /cgroup2

	sleep 3

	if echo "+io" > $dir/cgroup.subtree_control; then
		echo "successfully added io controller to cgroup2"
	else
		echo "failed adding controller to cgroup2"
	fi

	if [ ! -d ${dir}/group2 ]; then
		mkdir $dir/group2 
	fi

	#group1
#	if echo "+io" > $dir/group1/cgroup.subtree_control; then
#		echo "added io controller to group1"
#	else
#		echo "failed adding io controller to group1"
#	fi
#	
#	if [ ! -d ${dir}/group1/group11 ]; then
#		mkdir $dir/group1/group11 
#	fi
#	
#	if echo 100 > $dir/group1/group11/io.weight;then
#		echo "changed group11 weight to 100"
#	else
#		echo "failed changing weight group11"
#	fi
	
	#group2
	if echo "+io" > $dir/group2/cgroup.subtree_control; then
		echo "added io controller to group2"
	else
		echo "failed adding io controller to group2"
	fi
	
	if echo 100 > $dir/group2/io.weight; then
		echo "changed group2 weight to 100"
	else
		echo "failed changing weight"
	fi
	
	if [ ! -d ${dir}/group2/group21 ]; then
		mkdir $dir/group2/group21 $dir/group2/group22
	fi
	
	if echo 100 > $dir/group2/group21/io.weight;then
		echo "changed group21 weight to 100"
	else
		echo "failed changing weight group21"
	fi
	
	if echo 900 > $dir/group2/group22/io.weight;then
		echo "changed group22 weight to 900"
	else
		echo "failed changing weight group22"
	fi

else
	echo "type number of bash pid (0 for none)"
	read num
	
	if [ $num == "0" ]
	then
		echo "no pid"
	else
		for ((i=1;i<=${num};i++))
		do
			echo "type pid"
			read pid
			echo $i
			if [ $i == "1" ]
			then
				echo $pid > $dir/group2/group21/cgroup.procs
			elif [ $i == "2" ]
			then
				echo $pid > $dir/group2/group22/cgroup.procs
#			elif [ $i == "3" ]
#			then
#				echo $pid > $dir/group2/group22/group221/cgroup.procs	
#			elif [ $i == "4" ]
#			then
	#			echo $pid > $dir/group2/group22/group222/cgroup.procs	
	#		elif [ $i == "5" ]
	#		then
#				echo $pid > $dir/group3/group31/cgroup.procs	
#			elif [ $i == "5" ]
#			then
#				echo $pid > $dir/group4/group41/cgroup.procs	
	
			fi
		done
		fi
fi
