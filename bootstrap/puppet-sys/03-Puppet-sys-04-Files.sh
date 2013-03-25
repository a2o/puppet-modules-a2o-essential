#!/bin/bash



### Create symlink and executable
cd /usr/local &&
ln -s puppet-sys-*-init puppet-sys &&

if [ ! -e /usr/local/bin/puppet-sys ]; then
    echo '/usr/local/puppet-sys/bin/puppet $@' > /usr/local/bin/puppet-sys &&
    chmod 755 /usr/local/bin/puppet-sys
fi
