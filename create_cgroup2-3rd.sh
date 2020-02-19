#!/bin/bash
mountdir="/home/kwonje/mount"
dir="/sys/fs/cgroup"

#echo "type mount journal mode"
#read j_mode

echo bfq > /sys/block/sdc/queue/scheduler
echo 1 > /sys/block/sdc/queue/iosched/strict_guarantees

rmdir  $dir/group*/group*/group* $dir/group*/group* $dir/group*
umount /cgroup2
#rm -rf $mount/
umount $mountdir
#umount -v /dev/sdc1
mkfs -t ext4 /dev/sdc1
dumpe2fs /dev/sdc1 | head -n 10
mount /dev/sdc1 ${mountdir} -t ext4 -o data=ordered
mkdir /cgroup2
mount -t cgroup2 none /cgroup2

if echo "+io" > $dir/cgroup.subtree_control; then
	echo "successfully added io controller to cgroup2"
else
	echo "failed adding controller to cgroup2"
fi

if [ ! -d ${dir}/group1 ]; then
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

if echo 800 > $dir/group1/group11/io.bfq.weight;then
	echo "changed group11 weight to 150"
else
	echo "failed changing weight group11"
fi

#group2
if echo "+io" > $dir/group2/cgroup.subtree_control; then
	echo "added io controller to group2"
else
	echo "failed adding io controller to group2"
fi

if echo 200 > $dir/group2/io.bfq.weight; then
	echo "changed group2 weight to 200"
else
	echo "failed changing weight"
fi

if [ ! -d ${dir}/group2/group21 ]; then
	mkdir $dir/group2/group21 $dir/group2/group22
fi

if echo 500 > $dir/group2/group21/io.bfq.weight;then
	echo "changed group21 weight to 500"
else
	echo "failed changing weight group21"
fi

if echo 600 > $dir/group2/group22/io.bfq.weight;then
	echo "changed group22 weight to 550"
else
	echo "failed changing weight group22"
fi

if echo "+io" > $dir/group2/group22/cgroup.subtree_control; then
	echo "added io controller to group22"
else
	echo "failed adding io controller to group22"
fi

if [ ! -d ${dir}/group2/group22/group221 ]; then
	mkdir $dir/group2/group22/group221 $dir/group2/group22/group222
fi

if echo 200 > $dir/group2/group22/group221/io.bfq.weight;then
	echo "changed group221 weight to 200"
else
	echo "failed changing weight group221"
fi

if echo 800 > $dir/group2/group22/group222/io.bfq.weight;then
	echo "changed group222 weight to 800"
else
	echo "failed changing weight group222"
fi


#group3
if echo "+io" > $dir/group3/cgroup.subtree_control; then
	echo "added io controller to group3"
else
	echo "failed adding io controller to group3"
fi

if echo 300 > $dir/group3/io.bfq.weight; then
	echo "changed group3 weight to 300"
else
	echo "failed changing weight"
fi

if [ ! -d ${dir}/group3/group31 ]; then
	mkdir $dir/group3/group31
fi

if echo 300 > $dir/group3/group31/io.bfq.weight;then
	echo "changed group31 weight to 300"
else
	echo "failed changing weight group31"
fi

#group4
if echo "+io" > $dir/group4/cgroup.subtree_control; then
	echo "added io controller to group4"
else
	echo "failed adding io controller to group4"
fi

if echo 400 > $dir//group4/io.bfq.weight; then
	echo "changed group4 weight to 400"
else
	echo "failed changing weight"
fi

if [ ! -d ${dir}/group4/group41 ]; then
	mkdir $dir/group4/group41
fi

if echo 400 > $dir/group4/group41/io.bfq.weight;then
	echo "changed group41 weight to 400"
else
	echo "failed changing weight group41"
fi


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
			echo $pid > $dir/group2/group21/cgroup.procs
		elif [ $i == "3" ]
		then
			echo $pid > $dir/group2/group22/group221/cgroup.procs	
		elif [ $i == "4" ]
		then
			echo $pid > $dir/group2/group22/group222/cgroup.procs	
		elif [ $i == "5" ]
		then
			echo $pid > $dir/group3/group31/cgroup.procs	
		elif [ $i == "6" ]
		then
			echo $pid > $dir/group4/group41/cgroup.procs	

		fi
	done
fi
