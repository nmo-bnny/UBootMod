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




# Add malicious software

cp evilFiles/bootkit.c u-boot-2026.01/common/


cd u-boot-2026.01


# Adds config updates, deletes duplicates to prevent breaking

tmp=$(mktemp)

sed '
/^# Autorun "bootkit"/,/^CONFIG_BOARD_LATE_INIT=y[[:space:]]*$/d
' configs/malta_defconfig > "$tmp"

{
  printf '# Autorun "bootkit"\n\n# Calls post uBoot\nCONFIG_BOARD_LATE_INIT=y\n'
  cat "$tmp"
} > configs/malta_defconfig.new && mv configs/malta_defconfig.new configs/malta_defconfig

rm "$tmp"

tmp=$(mktemp)

sed '
/^# Bootkit[[:space:]]*$/,/^obj-y[[:space:]]*\+=[[:space:]]*bootkit\.o[[:space:]]*$/d
' common/Makefile > "$tmp"

{
  printf '# Bootkit\n\nobj-y += bootkit.o\n\n'
  cat "$tmp"
} > common/Makefile.new && mv common/Makefile.new common/Makefile

rm "$tmp"


# Make binary and run in QEMU

printf "\nUpdating configs and attempting to cross compile\n"
make distclean

make malta_defconfig

make CROSS_COMPILE=mips-linux-gnu-

printf "\nSuccess\n"

printf "\nFinally attempting to run QEMU\n To exit kill the PID\n"

qemu-system-mips -M malta -bios u-boot.bin -serial mon:stdio -m 256M -nographic
