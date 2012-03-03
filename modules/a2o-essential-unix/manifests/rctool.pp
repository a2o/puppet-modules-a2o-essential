# modules/a2o/a2o-essential-unix/manifests/rctool.pp



### RCtool for service management
class a2o-essential-unix::rctool inherits a2o-essential-unix::base {

    File {
        owner   => root,
        group   => root,
        mode    => 755,
    }


    # Service init script helper libraries
    file { '/etc/rc.d/rc._functions':   source => "puppet:///modules/$thisPuppetModule/rctool/rc._functions", }
}
