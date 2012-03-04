# modules/a2o/a2o-essential-linux/manifests/init.pp



################################################################################
### a2o essential linux server
################################################################################

class a2o-essential-linux::server-puppetonly {
    include 'a2o-essential-unix::compiletool'
    include 'a2o-essential-linux-openssl'
    include 'a2o-essential-linux-puppet'
}

################################################################################
### END a2o essential linux server
################################################################################
