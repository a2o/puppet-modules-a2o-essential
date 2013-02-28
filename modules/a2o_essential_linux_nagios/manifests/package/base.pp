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



### Software package base class
class   a2o_essential_linux_nagios::package::base   inherits   a2o_essential_linux_nagios::base {

    # CheckURI: http://www.nagios.org/download/core/thanks/
    $softwareName_nagios           = 'nagios'
    $softwareVersion_nagios        = '3.4.4'
    $packageRelease_nagios         = '1'
    $packageTag_nagios             = "$softwareName_nagios-$softwareVersion_nagios-$packageRelease_nagios"
    $destDir_nagios                = "/usr/local/$packageTag_nagios"

    # CheckURI: http://www.nagios.org/download/plugins/
    $softwareName_plugins          = 'nagios-plugins'
    $softwareVersion_plugins       = '1.4.16'

    if $a2o_linux_nagios_plugins_lite == 'true' {
        $packageRelease_plugins    = '2_lite'
    } else {
        $packageRelease_plugins    = '2'
    }

    $packageTag_plugins            = "$softwareName_plugins-$softwareVersion_plugins-$packageRelease_plugins"
    $destDir_plugins               = "/usr/local/$packageTag_plugins"

    # CheckURI: http://mathias-kettner.de/check_mk_download.html
    $softwareName_mk_livestatus    = "$packageTag_nagios-mk-livestatus"
    $softwareVersion_mk_livestatus = '1.2.0p4'
    $packageRelease_mk_livestatus  = '1'
    $packageEnsure_mk_livestatus   = "$softwareVersion_mk_livestatus-$packageRelease_mk_livestatus"
    $packageTag_mk_livestatus      = "$softwareName_mk_livestatus-$packageEnsure_mk_livestatus"
    $destDir_mk_livestatus         = "$destDir_nagios/mk-livestatus-$packageEnsure_mk_livestatus"

    # CheckURI: http://sourceforge.net/projects/pnp4nagios/
    $softwareName_pnp4nagios       = "$packageTag_nagios-pnp4nagios"
    $softwareVersion_pnp4nagios    = '0.6.19'
    $packageRelease_pnp4nagios     = '1'
    $packageEnsure_pnp4nagios      = "$softwareVersion_pnp4nagios-$packageRelease_pnp4nagios"
    $packageTag_pnp4nagios         = "$softwareName_pnp4nagios-$packageEnsure_pnp4nagios"
    $destDir_pnp4nagios            = "$destDir_nagios/pnp4nagios-$packageEnsure_pnp4nagios"

    # CheckURI: http://exchange.nagios.org/directory/Addons/Monitoring-Agents/NRPE--2D-Nagios-Remote-Plugin-Executor/details
    $softwareName_nrpe             = 'nrpe'
    $softwareVersion_nrpe          = '2.13'
    $packageRelease_nrpe           = '3'
    $packageTag_nrpe               = "$softwareName_nrpe-$softwareVersion_nrpe-$packageRelease_nrpe"
    $destDir_nrpe                  = "/usr/local/$packageTag_nrpe"


    ### External package references
    $externalDestDir_perl     = '/usr/local/perl-5.16.2-1'
    $externalDestDir_perllib  = '/usr/local/lib/perl/5.16.2'
    $externalDestDir_mysql    = '/usr/local/mysql-5.1.68-2'
    $externalDestDir_openldap = '/usr/local/openldap-2.4.33-2'
    $externalDestDir_openssl  = '/usr/local/openssl-1.0.1e-2'


    # Destination directories and symlinks
    $destDirSymlink_nagios             = "/usr/local/nagios"
    $destDirSymlink_nagios_dest        = "$packageTag_nagios"
    $destDirSymlink_plugins            = "/usr/local/nagios-plugins"
    $destDirSymlink_plugins_dest       = "$packageTag_plugins"
    $destDirSymlink_mk_livestatus      = "$destDir_nagios/mk-livestatus"
    $destDirSymlink_mk_livestatus_dest = "mk-livestatus-$packageEnsure_mk_livestatus"
    $destDirSymlink_pnp4nagios         = "$destDir_nagios/pnp4nagios"
    $destDirSymlink_pnp4nagios_dest    = "pnp4nagios-$packageEnsure_pnp4nagios"
    $destDirSymlink_nrpe               = "/usr/local/nrpe"
    $destDirSymlink_nrpe_dest          = "$packageTag_nrpe"


    # Where packages are compiled
    $compileDir = '/var/src/daemons'
}
