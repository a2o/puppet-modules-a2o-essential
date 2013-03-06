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



### Service base class: named
class   a2o_essential_linux_bind::distro::service_base   inherits   a2o_essential_linux_bind::base {

    # External resources
    $destDir_openssl = $a2o_essential_linux_bind::package::bind::destDir_openssl

    $require   = [
        File['/var/named'],
        File['/var/named/dev'],
        File['/var/named/etc/named'],
        File['/var/named/etc/named/managed-keys'],
        File['/var/named/etc/named/managed-keys/managed-keys.bind'],
        File['/var/named/log'],
        File['/var/named/run'],
        File['/var/named/var/named'],
        File['/var/named/zones/master'],
        File['/var/named/zones/slave'],
        File['/var/named/zones/dynamic'],
    ]

    $subscribe = [
        Package['bind'],
        File['/usr/local/bind'],
        File['/var/named/etc/named/named.conf'],
        File['/var/named/etc/named/rndc.key'],
        Exec['rndc-confgen /var/named/etc/named/rndc.key'],
        File['/var/named/zones/127.0.0'],
        File['/var/named/zones/localhost'],
        File['/var/named/zones/root.hints'],
    ]
}
