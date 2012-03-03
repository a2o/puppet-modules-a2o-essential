# modules/a2o/a2o-essential-unix/manifests/init.pp



### Base class
class   a2o-essential-unix::base   {
    $thisPuppetModule = 'a2o-essential-unix'

    File {
        owner    => root,
        group    => root,
        mode     => 644,
    }
}



### Miscelaneous tools
class a2o-essential-unix::tools-misc inherits a2o-essential-unix::base {

    file { '/bin/pidfind':     source => "puppet:///modules/$thisPuppetModule/tools/pidfind",  mode => 755, }
    file { '/bin/psfind':      source => "puppet:///modules/$thisPuppetModule/tools/psfind",   mode => 755, }
    file { '/usr/bin/untar':   source => "puppet:///modules/$thisPuppetModule/tools/untar",    mode => 755, }
}



### The final all-containing class
class a2o-essential-unix::server {
    include 'a2o-essential-unix::fhs'
    include 'a2o-essential-unix::compiletool'
    include 'a2o-essential-unix::rctool'
    include 'a2o-essential-unix::tools-misc'
}



### Minimal variation
class a2o-essential-unix::server-minimal {
    include 'a2o-essential-unix::fhs'
    include 'a2o-essential-unix::compiletool'
    include 'a2o-essential-unix::rctool'
}
