#!/bin/bash
mountdir="/home/kwonje/mount"
dir="/sys/fs/cgroup"
input
#echo "type mount journal mode"
#read j_mode

echo cfq > /sys/block/sdc/queue/scheduler
#echo 1 > /sys/block/sdc/queue/iosched/strict_guarantees
#echo 0 > /sys/block/sdc/queue/iosched/low_latency

echo "create new?"
read new
echo $new
if [ "$new" == "y" ]; then
	for ((i=1;i<=4;i++))
	do	
		find /sys/fs/cgroup/group${i}/ | grep "cgroup.procs" > temp
		input="./temp"
		while read line; 
		do
#			echo "$line"
			pid="$(cat ${line})"
			echo "$pid"
			echo $pid > ${dir}/cgroup.procs
		done < "$input"
#		read hi
#		pid="$(cat ${dir}/group${i}/group${i}1/cgroup.procs)" 
#			echo $pid
#			echo $pid > ${dir}/cgroup.procs
		
	done
	rmdir  $dir/group*/group*/group*/group* $dir/group*/group*/group* $dir/group*/group* $dir/group*
	umount /cgroup2
	rmdir /cgroup2
	#rm -rf $mount/
	echo "mount sdc?"
	read dev
	if [ "$dev" == "y" ]; then
		umount $mountdir
		#umount -v /dev/sdc1
		fdisk /dev/sdc
		mkfs -t ext4 /dev/sdc1
	#	dumpe2fs /dev/sdc1 | head -n 10
		mount /dev/sdc1 ${mountdir} -t ext4 -o data=ordered
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
		mkdir $dir/group1 $dir/group2 $dir/group3 $dir/group4
	fi

	#group1
	if echo "+io" > $dir/group1/cgroup.subtree_control; then
		echo "added io controller to group1"
	else
		echo "failed adding io controller to group1"
	fi
	
	if [ ! -d ${dir}/group1/group11 ]; then
		mkdir $dir/group1/group11 
	fi
	
	if echo 100 > $dir/group1/group11/io.weight;then
		echo "changed group11 weight to 100"
	else
		echo "failed changing weight group11"
	fi
	
	#group2
	if echo "+io" > $dir/group2/cgroup.subtree_control; then
		echo "added io controller to group2"
	else
		echo "failed adding io controller to group2"
	fi
	
	if echo 200 > $dir/group2/io.weight; then
		echo "changed group2 weight to 200"
	else
		echo "failed changing weight"
	fi
	
	if [ ! -d ${dir}/group2/group21 ]; then
		mkdir $dir/group2/group21 $dir/group2/group22 $dir/group2/group21/group211 $dir/group2/group21/group212
	fi
	
	if echo 900 > $dir/group2/group21/io.weight;then
		echo "changed group21 weight to 900"
	else
		echo "failed changing weight group21"
	fi
	
	if echo 100 > $dir/group2/group22/io.weight;then
		echo "changed group22 weight to 100"
	else
		echo "failed changing weight group22"
	fi

	if echo "+io" > $dir/group2/group21/cgroup.subtree_control; then
		echo "added io controller to group21"
	else
		echo "failed adding io controller to group21"
	fi


	if echo 300 > $dir/group2/group21/group211/io.weight;then
		echo "changed group21 weight to 300"
	else
		echo "failed changing weight group211"
	fi
	
	if echo 700 > $dir/group2/group21/group212/io.weight;then
		echo "changed group22 weight to 700"
	else
		echo "failed changing weight group212"
	fi

	#group3
	if echo "+io" > $dir/group3/cgroup.subtree_control; then
		echo "added io controller to group3"
	else
		echo "failed adding io controller to group3"
	fi
	
	if echo 300 > $dir/group3/io.weight; then
		echo "changed group3 weight to 300"
	else
		echo "failed changing weight"
	fi
	
	if [ ! -d ${dir}/group3/group31 ]; then
		mkdir $dir/group3/group31 $dir/group3/group31/group311 $dir/group3/group31/group312
	fi
	
	if echo 100 > $dir/group3/group31/io.weight;then
		echo "changed group21 weight to 100"
	else
		echo "failed changing weight group31"
	fi
	
	if echo "+io" > $dir/group3/group31/cgroup.subtree_control; then
		echo "added io controller to group31"
	else
		echo "failed adding io controller to group31"
	fi


	if echo 600 > $dir/group3/group31/group311/io.weight;then
		echo "changed group21 weight to 600"
	else
		echo "failed changing weight group311"
	fi
	
	if echo 400 > $dir/group3/group31/group312/io.weight;then
		echo "changed group22 weight to 400"
	else
		echo "failed changing weight group312"
	fi

	#group4
	if echo "+io" > $dir/group4/cgroup.subtree_control; then
		echo "added io controller to group4"
	else
		echo "failed adding io controller to group4"
	fi
	
	if echo 400 > $dir/group4/io.weight; then
		echo "changed group2 weight to 400"
	else
		echo "failed changing weight"
	fi
	
	if [ ! -d ${dir}/group4/group41 ]; then
		mkdir $dir/group4/group41 $dir/group4/group42 $dir/group4/group42/group421 $dir/group4/group42/group422 $dir/group4/group42/group423 $dir/group4/group42/group423/group4231 $dir/group4/group42/group423/group4232



	fi
	
	if echo 500 > $dir/group4/group41/io.weight;then
		echo "changed group41 weight to 500"
	else
		echo "failed changing weight group41"
	fi
	
	if echo 500 > $dir/group4/group42/io.weight;then
		echo "changed group42 weight to 500"
	else
		echo "failed changing weight group42"
	fi

	if echo "+io" > $dir/group4/group42/cgroup.subtree_control; then
		echo "added io controller to group42"
	else
		echo "failed adding io controller to group41"
	fi
	

	if echo 200 > $dir/group4/group42/group421/io.weight;then
		echo "changed group411 weight to 200"
	else
		echo "failed changing weight group211"
	fi
	
	if echo 300 > $dir/group4/group42/group422/io.weight;then
		echo "changed group412 weight to 300"
	else
		echo "failed changing weight group412"
	fi

	if echo 500 > $dir/group4/group42/group423/io.weight;then
		echo "changed group412 weight to 500"
	else
		echo "failed changing weight group412"
	fi

	if echo "+io" > $dir/group4/group42/group423/cgroup.subtree_control; then
		echo "added io controller to group423"
	else
		echo "failed adding io controller to group423"
	fi
	

	if echo 200 > $dir/group4/group42/group423/group4231/io.weight;then
		echo "changed group4231 weight to 200"
	else
		echo "failed changing weight group211"
	fi
	
	if echo 800 > $dir/group4/group42/group423/group4232/io.weight;then
		echo "changed group4232 weight to 800"
	else
		echo "failed changing weight group412"
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
				echo $pid > $dir/group1/group11/cgroup.procs
			elif [ $i == "2" ]
			then
				echo $pid > $dir/group2/group21/group211/cgroup.procs
			elif [ $i == "3" ]
			then
				echo $pid > $dir/group2/group21/group212/cgroup.procs	
			elif [ $i == "4" ]
			then
				echo $pid > $dir/group2/group22/cgroup.procs	
			elif [ $i == "5" ]
			then
				echo $pid > $dir/group3/group31/group311/cgroup.procs	
			elif [ $i == "6" ]
			then
				echo $pid > $dir/group3/group31/group312/cgroup.procs	
			elif [ $i == "7" ]
			then
				echo $pid > $dir/group4/group41/cgroup.procs	
			elif [ $i == "8" ]
			then
				echo $pid > $dir/group4/group42/group421/cgroup.procs	
			elif [ $i == "9" ]
			then
				echo $pid > $dir/group4/group42/group422/cgroup.procs	
			elif [ $i == "10" ]
			then
				echo $pid > $dir/group4/group42/group423/group4231/cgroup.procs	
			elif [ $i == "11" ]
			then
				echo $pid > $dir/group4/group42/group423/group4232/cgroup.procs	

			fi
		done
		fi
fi
