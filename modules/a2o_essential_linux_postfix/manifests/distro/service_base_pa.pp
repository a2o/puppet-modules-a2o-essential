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



### Service base class: postfix with PA
class   a2o_essential_linux_postfix::distro::service_base_pa   inherits   a2o_essential_linux_postfix::distro::service_base_common {

    $destDir_openssl = $a2o_essential_linux_postfix::package::postfix_pa::destDir_openssl

    $require   = [
	$requireCommon,
	Package['mysql'],
	Service['a2o-linux-mysqld'],
	Service['a2o-linux-clamav-milter'],
	Service['a2o-linux-opendkim'],
    ]

    $subscribe = [
	$subscribeCommon,
	Package['postfix-pa'],
	File['/etc/postfix/mysql_relay_domains.cf'],
	File['/etc/postfix/mysql_virtual_alias_maps.cf'],
        File['/etc/postfix/mysql_virtual_domain_maps.cf'],
	File['/etc/postfix/mysql_virtual_mailbox_maps.cf'],
        File['/etc/postfix/mysql_virtual_mailbox_limit_maps.cf'],
    ]
}
