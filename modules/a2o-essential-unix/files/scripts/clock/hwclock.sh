#!/bin/bash
###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) 2012 Bostjan Skufca                                       #
#-------------------------------------------------------------------------#
# This source file is subject to version 2.0 of the Apache License,       #
# that is bundled with this package in the file LICENSE, and is           #
# available through the world-wide-web at the following url:              #
# http://www.apache.org/licenses/LICENSE-2.0                              #
#-------------------------------------------------------------------------#
# Authors: Bostjan Skufca <my_name [at] a2o {dot} si>                     #
###########################################################################



### Check if changing hardware clock is applicable
if [ ! -e /dev/rtc ]; then
    echo "ERROR: No /dev/rtc found, aborted."
    exit
fi

if [ "`cat /proc/cpuinfo | grep -c QEMU | cat`" -gt "0" ]; then
    echo "WARNING: This system runs as a virtual machine (KVM), aborted."
    exit
fi



### Store
# Whether UTC or localtime is used, hwclock determines from /etc/adjtime
/sbin/hwclock --systohc
