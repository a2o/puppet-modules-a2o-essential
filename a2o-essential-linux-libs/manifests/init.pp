# modules/a2o-basic/a2o-basic-linux-libs/manifests/init.pp



### Base class
class a2o-basic-linux-libs::base {
    $thisPuppetModule = "a2o-basic-linux-libs"

    # External packages
    $externalPackageDestdir_openssl = '/usr/local/openssl-1.0.0f-1'

    # Where the packages will be compiled
    $compileDir = '/var/src/libs'
}



### Final all-containing class
class a2o-basic-linux-libs {
    include 'a2o-basic-linux-libs::confuse'
}
