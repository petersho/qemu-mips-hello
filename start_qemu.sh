#!/bin/bash
#
# Usage: start_qemu.sh [image_file] [-debug]
#
# If '-debug' is specified, the Qemu will be executed with additional "-S -s" flags.
# This will cause Qemu to act as a GDB server, listening on the TCP port 1234.
# Execution of the image will freeze at the startup point.
#

# Default firmware image
DEF_IMAGE_FILE=bin/image.elf

# Qemu arguments to invoke Qemu with a GDB server listening on the 
# TCP port 1234 and freeze execution of the image at startup.
QEMU_GDB='-S -s'

# Initial values of both Qemu arguments:
QEMU_GDB_ARG=''
IMAGE_FILE=''

# Check all CLI arguments to this script. The first argument, not equal
# to "-debug", will be considered as the desired image name. All 
# remaining arguments, not equal to "-debug", will be discarded.
 
for arg in $*; do
  if [ "$arg" = '-debug' ]; then
    QEMU_GDB_ARG=$QEMU_GDB;
  else
    if [ "$IMAGE_FILE" = '' ]; then
      IMAGE_FILE=$arg
    fi
  fi
done

# If no image file has been provided, assign it the default name.
if [ "$IMAGE_FILE" = '' ]; then
  IMAGE_FILE=$DEF_IMAGE_FILE
fi

QEMUBIN=qemu-system-mipsel

$QEMUBIN -M mips -nographic -kernel $IMAGE_FILE $QEMU_GDB_ARG
