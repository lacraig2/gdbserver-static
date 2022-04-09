set -x
GDB=$1
ARCH=$2
cd $GDB
mkdir build-linux-$ARCH
cd build-linux-$ARCH
../configure CXXFLAGS="-fPIC -static" --host="$ARCH-linux-gnueabi"
make -j`nproc`