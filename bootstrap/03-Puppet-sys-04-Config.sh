#!/bin/bash



### Create default /etc/puppet-sys/puppet.conf
mkdir -p /etc/puppet-sys &&
cat <<EOF > /etc/puppet-sys/puppet.conf
[agent]
server            = PUPPETMASTER_HOST_SYS
masterport        = 18140
runinterval       = 3600

certname          = HOSTNAME
environment       = PUPPET_ENVIRONMENT

pluginsync        = true
ignorecache       = true
usecacheonfailure = false

report            = true
graph             = true
EOF
