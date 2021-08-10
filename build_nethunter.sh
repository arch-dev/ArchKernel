#!/bin/bash

# Toolchain PATH
PATH="/home/arch-dev/android/dotos/prebuilts/clang/host/linux-x86/clang-r353983c/bin:/home/arch-dev/android/dotos/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:${PATH}"

DEFCONFIG=nethunter_defconfig
VERSION=NHArchKernel-Custom-OneVision-v1.0

# Compilation variables
ARCH=arm64
CC=clang
CLANG_TRIPLE=aarch64-linux-gnu-
CROSS_COMPILE=aarch64-linux-android-

echo Starting ${VERSION} build...

make ARCH=$ARCH $DEFCONFIG
make -j2 LOCALVERSION=-${VERSION} ARCH=$ARCH CC=$CC CLANG_TRIPLE=$CLANG_TRIPLE CROSS_COMPILE=$CROSS_COMPILE

echo Bulding AnyKernel3 flashable zip...

cp -rf arch/$ARCH/boot/Image AnyKernel3/Image
[ -e ${VERSION}.zip ] && rm ${VERSION}.zip
zip -r9 ${VERSION}.zip AnyKernel3/* -x .git README.md *placeholder

echo Build finished. You can find the flashable under the root dir.
