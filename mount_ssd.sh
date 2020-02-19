#!/bin/sh

  
    umount /home/kwonje/mount
  	echo umount finish
	mkfs.ext4 /dev/sdc1
    mount -t ext4 /dev/sdc1 /home/kwonje/mount
    echo mount finish

    fstrim / -v

