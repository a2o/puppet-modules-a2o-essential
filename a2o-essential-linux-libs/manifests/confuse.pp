# modules/a2o-essential/a2o-essential-linux-libs/manifests/confuse.pp



### Software package: confuse
class   a2o-essential-linux-libs::confuse   inherits   a2o-essential-linux-libs::base {

    # Software details
    $packageName            = 'confuse'
    $packageSoftware        = 'confuse'
    $packageSoftwareVersion = '2.6'
    $packageRelease         = '1'
    $packageEnsure          = "$packageSoftwareVersion-$packageRelease"
    $packageTag             = "$packageSoftware-$packageEnsure"
    $installScriptTpl       = "install-$packageSoftware.sh"
    $installScript          = "install-$packageTag.sh"


    # Installation
    file { "$compileDir/$installScript":
	content  => template("$thisPuppetModule/$installScriptTpl"),
        owner    => root,
        group    => root,
        mode     => 755,
	require  => [
	    File["/var/src/build_functions.sh"],
	],
    }
    package { "$packageName":
	provider => 'a2o_linux_compiletool',
        ensure   => "$packageEnsure",
	source   => "$compileDir/$installScript",
	require  => [
	    File["$compileDir/$installScript"],
	],
    }
}
