BASE=`realpath ..`
GDB=gdb-11.2

mkdir -p built
if [ ! -d ./$GDB ]
then
    echo "Downloading GDB"
    wget https://ftp.gnu.org/gnu/gdb/$GDB.tar.gz
    tar -xzf gdb-11.2.tar.gz
fi

for arch in arm64 armv5 armv6 armv7 armv7l-musl armv7a mips mipsel ppc64le \
    m68k-uclibc riscv32 riscv64 s390x xtensa-uclibc x86 x64
do
    
    source $BASE/shared/dockcross.sh $BASE $arch

    echo "Building gdbserver for $arch"
    if [ $arch == "x86" ]
    then
        $BASE/dockcross/dockcross-linux-$arch  bash run_arch.sh $GDB i386
        find ./$GDB/build-linux-i386 -name "gdbserver" -type f -exec cp {} $BASE/built/gdbserver-$arch \;
    else
        $BASE/dockcross/dockcross-linux-$arch  bash run_arch.sh $GDB $arch
        find ./$GDB/build-linux-$arch -name "gdbserver" -type f -exec cp {} $BASE/built/gdbserver-$arch \;
    fi
done