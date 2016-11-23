#!/bin/bash

# The 1st element represents the process's PID, the 5th element represents its full path

PID=`ps a | awk '$5~/qemu-system-mipsel$/ {print $1}'`

# Once the process's PID is known, its termination is very trivial:
kill $PID
