BASE=`realpath ..`
BUSYBOX=busybox
BUSYBOX_REVISION=e512aeb0fb3c585948ae6517cfdf4a53cf99774d
DOCK_REVISION=5924c2d5800d73ca50765805c390273c9e0b0380

if [ ! -d ./$BUSYBOX ]
then
    echo "Downloading Busybox"
    git clone https://github.com/mirror/busybox 
    git checkout $BUSYBOX_REVISION
fi

#arm64 armv5 armv6 armv7 armv7l-musl armv7a mips mipsel ppc64le \
#    m68k-uclibc riscv32 riscv64 s390x xtensa-uclibc x86 x64

for arch in mipsel
do
    
    source $BASE/shared/dockcross.sh $BASE $arch

    echo "Building busybox for $arch"
    $BASE/dockcross/dockcross-linux-$arch  bash run_arch.sh $arch
    find $BUSYBOX -name "busybox_unstripped" -type f -exec cp {} $BASE/built/busybox-$arch \;
done