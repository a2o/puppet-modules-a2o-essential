#!/bin/sh
###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) Bostjan Skufca                                            #
#-------------------------------------------------------------------------#
# This source file is subject to version 2.0 of the Apache License,       #
# that is bundled with this package in the file LICENSE, and is           #
# available through the world-wide-web at the following url:              #
# http://www.apache.org/licenses/LICENSE-2.0                              #
#-------------------------------------------------------------------------#
# Authors: Bostjan Skufca <my_name [at] a2o {dot} si>                     #
###########################################################################



### Try postfix first
if /bin/ps aux | grep 'libexec/postfix/master$' > /dev/null; then
    /etc/ganglia/data_collectors/a2o/mail_queue-postfix.sh
    exit $?
fi


### Then exim
if /bin/ps aux | grep '/usr/sbin/exim ' > /dev/null; then
    /etc/ganglia/data_collectors/a2o/mail_queue-exim.sh
    exit $?
fi
