#!/bin/bash


# This file builds a standard environment and runs it (it is meant to show a regular uBoot env)





# Install packages

printf "\nAttempting to install qemu-system-mips (big-endian)\n"

sudo apt install qemu-system-mips

printf "\nInstalled\n"


printf "\nAttempting to install build tools\n"

sudo apt install bison flex libncurses5-dev

printf "\nInstalled\n"


printf "\nAttempting to install MIPS cross-compiler\n"

sudo apt install gcc-mips-linux-gnu

printf "\nInstalled\n"





# Extract UBoot

printf "\nAttempting to extract uBoot\n"

tar -xjf u-boot-2026.01.tar.bz2

printf "\nExtracted\n"

cd u-boot-2026.01



# Make binary and run in QEMU

printf "\nUpdating configs and attempting to cross compile\n"
make distclean

make malta_defconfig

make CROSS_COMPILE=mips-linux-gnu-

printf "\nSuccess\n"

printf "\nFinally attempting to run QEMU\n To exit kill the PID\n"

qemu-system-mips -M malta -bios u-boot.bin -serial mon:stdio -m 256M -nographic
