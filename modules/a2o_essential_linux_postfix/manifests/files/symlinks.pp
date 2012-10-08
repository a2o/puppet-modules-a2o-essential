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



### Symlinks to programs
class   a2o_essential_linux_postfix::files::symlinks   inherits   a2o_essential_linux_postfix::base {

    # Template
    File {
	ensure   => link,
        owner    => root,
        group    => root,
        mode     => 755,
	require  => File['/usr/local/postfix'],
    }

    file { '/usr/bin/mailq':         target => '/usr/local/postfix/bin/mailq'      }
    file { '/usr/bin/newaliases':    target => '/usr/local/postfix/bin/newaliases' }
    file { '/usr/sbin/postalias':    target => '/usr/local/postfix/sbin/postalias' }
    file { '/usr/sbin/postcat':      target => '/usr/local/postfix/sbin/postcat'   }
    file { '/usr/sbin/postconf':     target => '/usr/local/postfix/sbin/postconf'  }
    file { '/usr/sbin/postdrop':     target => '/usr/local/postfix/sbin/postdrop'  }
    file { '/usr/sbin/postfix':      target => '/usr/local/postfix/sbin/postfix'   }
    file { '/usr/sbin/postkick':     target => '/usr/local/postfix/sbin/postkick'  }
    file { '/usr/sbin/postlock':     target => '/usr/local/postfix/sbin/postlock'  }
    file { '/usr/sbin/postlog':      target => '/usr/local/postfix/sbin/postlog'   }
    file { '/usr/sbin/postmap':      target => '/usr/local/postfix/sbin/postmap'   }
    file { '/usr/sbin/postmulti':    target => '/usr/local/postfix/sbin/postmulti' }
    file { '/usr/sbin/postqueue':    target => '/usr/local/postfix/sbin/postqueue' }
    file { '/usr/sbin/postsuper':    target => '/usr/local/postfix/sbin/postsuper' }
    file { '/usr/sbin/sendmail':     target => '/usr/local/postfix/sbin/sendmail'  }
}
