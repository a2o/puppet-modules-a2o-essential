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

dir-merge .rsync-filter
dir-merge .rsync-filter.site

- /aquota.user
+ /backup
- /backup/***
+ /dev/pts
- /dev/pts/***
+ /dev/.udev
- /dev/.udev/***
+ /home
- /home/***
+ /media/*
- /media/*/***
+ /mnt/*
- /mnt/*/***
+ /opt/***
+ /proc
- /proc/***
- /quota.user
- /ramdisk*/***
+ /root
- /root/.cpan/***
+ /root/test
- /root/test/***
+ /root/tmp
- /root/tmp/***
+ /root/***
+ /sys
- /sys/***
+ /tmp
+ /tmp/php
+ /tmp/php/*
- /tmp/php/*/***
- /tmp/***
+ /usr/home
- /usr/home/***
+ /usr/local/apache/domlogs
- /usr/local/apache/domlogs/***
+ /usr/local/apache/logs
- /usr/local/apache/logs/***
- /usr/local/cpanel/logs/*log
+ /usr/local/cpanel-rollback
- /usr/local/cpanel-rollback/***
+ /usr/obj
- /usr/obj/***
+ /usr/ports
- /usr/ports/***
- /usr/src/***
- /usr/swap*
- /usr/tmpDSK*
+ /var
- /var/***
