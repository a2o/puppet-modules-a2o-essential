#!/bin/bash



### Create default /etc/puppet-sys/puppet.conf
cat <<EOF > /etc/puppet-sys/puppet.conf
[agent]
server            = PUPPETMASTER_HOST_SYS
masterport        = 18140
runinterval       = 3600

certname          = HOSTNAME
environment       = PUPPET_ENVIRONMENT_SYS

pluginsync        = true
ignorecache       = true
usecacheonfailure = false

report            = true
graph             = true
EOF



### Substitute with environmental variables, if applicable
if [ "x$NEW_HOSTNAME" != "x" ]; then
    perl -pi -e "s/HOSTNAME/$NEW_HOSTNAME/" /etc/puppet-sys/puppet.conf
fi
if [ "x$PUPPETMASTER_HOST_SYS" != "x" ]; then
    perl -pi -e "s/PUPPETMASTER_HOST_SYS/$PUPPETMASTER_HOST_SYS/" /etc/puppet-sys/puppet.conf
fi
if [ "x$PUPPET_ENVIRONMENT_SYS" != "x" ]; then
    perl -pi -e "s/PUPPET_ENVIRONMENT_SYS/$PUPPET_ENVIRONMENT_SYS/" /etc/puppet-sys/puppet.conf
fi
