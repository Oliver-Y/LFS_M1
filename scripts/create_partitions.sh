#!/bin/bash

export LFS=/mnt/lfs 
LFS_DEV=/dev/sdb
#Check to see if device exists, if it does then format
if [ -e $LFS_DEV ]; then 
	echo "Formatting Disk"
	mkfs -v -t ext4 $LFS_DEV
fi 


if [ ! -d $LFS ]; then 
	echo "Creating Mount Point" 
	mkdir -pv $LFS 
	mount -v -t ext4 $LFS_DEV $LFS 
fi 

