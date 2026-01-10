# UBootMod

Ethical Notice

The scripts shown here are for educational purposes only. Do not attempt to flash systems
or replicate the actions for malicious purposes.

# Dependencies

qemu-system-mips (1:8.2.2+ds-0ubuntu1.11)
bison (2:3.8.2+dfsg-1build2).
flex (2.6.4-8.2build1).
libncurses-dev (6.4+20240113-1ubuntu2)
gcc-mips-linux-gnu (4:12.2.0-4)


# Getting started

To get started, clone the repository and navigate to the UBootMod directory.

To launch the standard U-Boot environment, execute the safeEnv.sh script.

To start the modified U-Boot environment, run the evilEnv.sh script, which will display three rabbits as an indicator of the modified environment.

# Command

bash <filename.sh> 

This setup serves as a demonstration of how malicious programs can be executed during the boot process, highlighting the potential risks of flashing compromised environments onto vulnerable systems.


# Troubleshooting

Make sure all dependency versions are correct and installed properly

Make sure the evilFiles/bootkit.c is inside of u-boot-2026.01/common

Make sure the u-boot-2026.01/common/Mainfile has the following text at the top of the page 
obj-y += bootkit.o

Make sure the u-boot-2026.01/configs/malta_defconfig file contains the follow line
CONFIG_BOARD_LATE_INIT=y

# Warning

This project has only been tested on debian based systems
