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



### Service base class: postfix
class   a2o_essential_linux_postfix::distro::service_base_common   inherits   a2o_essential_linux_postfix::base {

    $requireCommon   = [
        File['/etc/postfix/access'],
        File['/etc/postfix/aliases'],
        File['/etc/postfix/recipients'],
        File['/etc/postfix/senders'],
        File['/etc/postfix/transport'],
        File['/etc/postfix/virtual'],
        File['/etc/postfix/virtual_domains'],
        File['/usr/bin/newaccess'],
        File['/usr/bin/newrecipients'],
        File['/usr/bin/newsenders'],
        File['/usr/bin/newtransport'],
        File['/usr/bin/newvirt'],
        File['/var/postfix'],
        File['/var/postfix/spool'],
        File['/var/postfix/spool/maildrop'],
        Service['a2o-linux-dovecot'],
    ]

    $subscribeCommon = [
	File['/usr/local/postfix'],
        File['/etc/postfix/main.cf-global'],
        File['/etc/postfix/master.cf'],
    ]
}
