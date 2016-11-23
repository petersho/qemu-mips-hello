# qemu-mips-hello


# Toolchain
Download buildroot-2016.08.1.tar.bz2 form http://buildroot.org/download.html
Select Target Architecture for MIPS little endian and Build cross gdb for the host
with Simulator support.

# Run
To run the target image in Qemu, enter the following command:

`qemu-system-mipsel -M mips -nographic -kernel bin/image.elf`
