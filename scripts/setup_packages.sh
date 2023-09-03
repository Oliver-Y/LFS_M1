export LFS=/mnt/lfs
PACKAGE_LOC=/home/parallels/LFS/scripts/packages
PATCH_LOC=/home/parallels/LFS/scripts/patches


if [ ! -d $LFS/sources ]; then 
	mkdir -v $LFS/sources 
	chmod -v a+wt $LFS/sources
fi 

if [ ! -d $PACKAGE_LOC ]; then 
	mkdir -v $PACKAGE_LOC 

fi 
if [ ! -d $PATCH_LOC ]; then 
	mkdir -v $PATCH_LOC 
fi 


pushd $PACKAGE_LOC
#Download Packages into the Cached Location 
cat packages.txt | while read line; do 
	NAME="`echo $line | cut -d\; -f1`"
	URL="`echo $line | cut -d\; -f2`"
	MD5SUM="`echo $line | cut -d\; -f3`"
	echo "$NAME.tar.gz"
	if [ -f "$NAME.tar.gz" ] || [ -f "$NAME.tar.xz" ] || [ -f "$NAME.tar.bzip" ]; then 
		echo "Skipping $NAME" 
		break
		continue 
	fi 
	echo "Downloading $NAME" 
	#wget $URL
	#Fun the checkSum delete if not correct 
	if [[ `md5sum "$NAME.tar.gz"` != $MD5SUM ]]; then 
		echo "Check Sum Doesn't match, deleting file" 
	#	rm "$NAME.tar.gz"
	fi 
done 
popd

pushd $PATCH_LOC
#Do the same with patches
cat patches.txt | while read line; do 
	NAME="`echo $line | cut -d\; -f1`"
	URL="`echo $line | cut -d\; -f2`"
	MD5SUM="`echo $line | cut -d\; -f3`"
	echo "$NAME.tar.gz"
	if [ -f "$NAME.tar.gz" ] || [ -f "$NAME.tar.xz" ] || [ -f "$NAME.tar.bzip" ]; then 
		echo "Skipping $NAME" 
		break
		continue 
	fi 
	echo "Downloading $NAME" 
	wget $URL
	#Fun the checkSum delete if not correct 
	if [[ `md5sum "$NAME.tar.gz"` != $MD5SUM ]]; then 
		echo "Check Sum Doesn't match, deleting file" 
	#	rm "$NAME.tar.gz"
	fi 
done 
popd
