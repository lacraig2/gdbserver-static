ARCH=$1
cd busybox
make clean

if [ $ARCH == "mipsel" ]
then
    CP=$ARCH-linux-gnu-
    ARCH=mips
else
    CP=$ARCH-linux-gnueabi-
fi
make ARCH=$ARCH CROSS_COMPILE=$CP defconfig
echo "CONFIG_DEBUG=y" >> .config 
make ARCH=$ARCH CROSS_COMPILE=$CP LDFLAGS="--static"  -j`nproc`