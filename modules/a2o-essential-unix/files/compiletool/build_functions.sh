#!/bin/bash
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



export SUCCESS=0
export FAILURE=255



### Get configuration if exists
if [ -f /var/src/build_functions.conf-site ]; then
    . /var/src/build_functions.conf-site
fi
if [ -f /var/src/build_functions.conf ]; then
    . /var/src/build_functions.conf
fi



CheckSrcRoot ()
{
    if [ ! -n "$SRCROOT" ]; then
	return $FAILURE
    else
	return $SUCCESS
    fi
}



GetNoTestArchive ()
{
    echo "----------[ Retrieving archive ]------------------------------"
    CheckSrcRoot &&
    cd $SRCROOT &&

    if [ "x$CTOOL_PROXY_URI" != "x" ]; then
	# Proxy-ed download
        RES=`echo "$PURI" | grep -c "$CTOOL_PROXY_EXCEPTION_REGEX" | cat` &&
	if [ "$RES" -gt "0" ]; then
	    wget -c --no-check-certificate --inet4-only --timeout=10 --tries=4 $PURI

	elif [ "`wget --help | grep -c content-disposition | cat`" -gt "0" ]; then
    	    wget -c --no-check-certificate --inet4-only --timeout=120 --tries=2 \
	    --content-disposition "${CTOOL_PROXY_URI}${PURI}"

	else
	    # Older wget, does not support --content-disposition switch (1.10 for example)
	    FILENAME=`echo $PURI | awk -F/ '{print $NF}'`
    	    wget -c --no-check-certificate --inet4-only --timeout=120 --tries=2 \
	    --output-document=$FILENAME "${CTOOL_PROXY_URI}${PURI}"
	fi

    else

	# Direct download
#	if [ "`wget --help | grep -c content-disposition | cat`" -gt "0" ]; then
#    	    wget -c --no-check-certificate --inet4-only --timeout=120 --tries=2 \
#	    --content-disposition "${PURI}"
#
#	else
	    # Older wget, does not support --content-disposition switch (1.10 for example)
	    FILENAME=`echo $PURI | awk -F/ '{print $NF}'`
    	    wget -c --no-check-certificate --inet4-only --timeout=120 --tries=2 \
		--output-document=$FILENAME "${PURI}"
#	fi

    fi # CTOOL_PROXY_URI

    RES=$?
    if [ "$RES" != "0" ]; then
	exit 1
    fi
}



GetArchive ()
{
    GetNoTestArchive
    if [ "$?" != "0" ]; then
	return $FAILURE
    fi
}



UnpackArchive ()
{
    CheckSrcRoot &&
    cd $SRCROOT &&
    if [ ! -e $PDIR ]; then
	UnpackNoTestArchive
    fi
}



UnpackNoTestArchive ()
{
    CheckSrcRoot &&
    cd $SRCROOT &&
    UnpackHere
}



UnpackHere ()
{
    echo; echo "----------[ Unpacking archive ]------------------------------"
    if [[ ! -z `echo $PFILE | grep '\.\(tar\.gz\|tgz\)$'` ]]; then
	tar -xzf $PFILE
    elif [[ ! -z `echo $PFILE | grep '\.tar\.bz2$'` ]]; then
	tar -xjf $PFILE
    elif [[ ! -z `echo $PFILE | grep '\.tar\.xz$'` ]]; then
	xz -dc $PFILE | tar -x
    elif [[ ! -z `echo $PFILE | grep '\.tar$'` ]]; then
	tar -xf $PFILE
    elif [[ ! -z `echo $PFILE | grep '\.zip$'` ]]; then
	unzip $PFILE
    else
	echo "ERROR - unknown archive $PFILE" &&
	return $FAILURE
    fi
}



CleanArchive ()
{
    CheckSrcRoot &&
    cd $SRCROOT/$PDIR &&

    echo; echo "----------[ make clean ]------------------------------"
    make clean
    echo; echo "----------[ make realclean ]------------------------------"
    make realclean
    echo; echo "----------[ make distclean ]------------------------------"
    make distclean
    return $SUCCESS
}



GetUnpack ()
{
    CheckSrcRoot &&
    GetArchive &&
    UnpackArchive &&
    echo &&
    echo "----------[ Configuring, building and installing ]------------------------------"
}



GetUnpackCd ()
{
    CheckSrcRoot &&
    GetArchive &&
    UnpackArchive &&
    cd $SRCROOT/$PDIR &&
    echo &&
    echo "----------[ Configuring, building and installing ]------------------------------"
}



GetUnpackClean ()
{
    CheckSrcRoot &&
    GetArchive &&
    UnpackArchive &&
    CleanArchive &&
    echo &&
    echo "----------[ Configuring, building and installing ]------------------------------"
}



################################################################################
###
### PHP PECL/PEAR channel/package discover/update/install/upgrade functions
###
################################################################################

###
### Channel discovery
###
php_discoverChannel_pear() {
    PHP_PREFIX="$1"
    PHP_CHN_NAME="$2"

    # Check & evaluate
    RES=`$PHP_PREFIX/bin/pear list-channels 2>/dev/null | tail -n +4 | grep "^$PHP_CHN_NAME " -c | cat`
    if [ "$?" != "0" ]; then
	echo "ERROR: Failed checking if channel is already discovered: $PHP_CHN_NAME"
	return 10
    fi

    # Discover if required
    if [ "$RES" == "0" ]; then
	$PHP_PREFIX/bin/pear channel-discover $PHP_CHN_NAME
	if [ "$?" != "0" ]; then
	    echo "ERROR: Unable to discover PEAR channel: $PHP_CHN_NAME"
	    return 1
	fi
	echo "INFO: PEAR channel discovered: $PHP_CHN_NAME"
    fi

    # Update
    $PHP_PREFIX/bin/pear channel-update $PHP_CHN_NAME
    if [ "$?" != "0" ]; then
        echo "ERROR: Unable to update PEAR channel: $PHP_CHN_NAME"
        return 1
    fi
    echo "INFO: PEAR channel updated: $PHP_CHN_NAME"
}



###
### Package check
###
_php_isPackageInstalled() {
    PHP_PREFIX="$1"
    PHP_PKG_TYPE="$2"
    PHP_PKG_NAME="$3"

    # Exec
    RES=`$PHP_PREFIX/bin/$PHP_PKG_TYPE list -a |   grep -v '^INSTALLED PACKAGES, ' | grep -v '^===============' | grep -v '^PACKAGE ' | grep -Fv '(no packages installed)'| grep -v '^$'   | grep "^$PHP_PKG_NAME " -c | cat`
    if [ "$?" != "0" ]; then
	echo "ERROR: Failed checking if package is installed: $PHP_PKG_NAME"
	exit 10
    fi

    # Evaluate
    if [ "$RES" == "0" ]; then
	return 1
    elif [ "$RES" == "1" ]; then
	return 0
    else
	echo "Invalid result while checking for $PHP_PKG_NAME: $RES"
	exit 5
    fi
}
php_isPackageInstalled_pecl() {
    PHP_PREFIX="$1"
    PHP_PKG_NAME="$2"
    _php_isPackageInstalled "$PHP_PREFIX" "pecl" "$PHP_PKG_NAME"
}
php_isPackageInstalled_pear() {
    PHP_PREFIX="$1"
    PHP_PKG_NAME="$2"
    _php_isPackageInstalled "$PHP_PREFIX" "pear" "$PHP_PKG_NAME"
}


###
### Package installation
###
php_installPackage_pecl() {
    PHP_PREFIX="$1"
    PHP_PKG_NAME_SEARCH="$2"
    PHP_PKG_NAME_INSTALL="$3"
    _php_installPackage "$PHP_PREFIX" "pecl" "$PHP_PKG_NAME_SEARCH" "$PHP_PKG_NAME_INSTALL"
}
php_installPackage_pear() {
    PHP_PREFIX="$1"
    PHP_PKG_NAME_SEARCH="$2"
    PHP_PKG_NAME_INSTALL="$3"
    _php_installPackage "$PHP_PREFIX" "pear" "$PHP_PKG_NAME_SEARCH" "$PHP_PKG_NAME_INSTALL"
}
_php_installPackage() {
    PHP_PREFIX="$1"
    PHP_PKG_TYPE="$2"
    PHP_PKG_NAME_SEARCH="$3"
    PHP_PKG_NAME_INSTALL="$4"

    # If empty, search an install names are the same
    if [ "x$PHP_PKG_NAME_INSTALL" == "x" ]; then
	PHP_PKG_NAME_INSTALL="$PHP_PKG_NAME_SEARCH"
    fi
    php_isPackageInstalled_$PHP_PKG_TYPE "$PHP_PREFIX" "$PHP_PKG_NAME_SEARCH"
    RETVAL=$?
    if [ "$RETVAL" == "0" ]; then
	echo "INFO: $PHP_PKG_TYPE package $PHP_PKG_NAME_INSTALL already installed"
    elif [ "$RETVAL" == "1" ]; then
	yes "" | $PHP_PREFIX/bin/$PHP_PKG_TYPE upgrade --force $PHP_PKG_NAME_INSTALL
	php_isPackageInstalled_$PHP_PKG_TYPE "$PHP_PREFIX" "$PHP_PKG_NAME_SEARCH"
        RETVAL=$?
	if [ "$RETVAL" == "1" ]; then
	    exit 6
	fi
	echo "INFO: $PHP_PKG_TYPE package $PHP_PKG_NAME_INSTALL installed"
    else
	echo "ERROR: Invalid return value from function: $RETVAL"
	exit 6
    fi
}




################################################################################
###
### ELF patching capabilities
###
################################################################################

_patchelf_rpath_orderDesc() {

    # Parameters
    EXECUTABLE="$1"
    EXECUTABLE_BACKUP="$EXECUTABLE.orig.patchelf.rpath.orderDesc"

    # Backup first, but do not override previous backup
    if [ ! -f $EXECUTABLE_BACKUP ]; then
	cp $EXECUTABLE $EXECUTABLE_BACKUP
    fi

    # Get and mangle rpath
    RPATH_ORIG=`readelf -d $PHP_EXECUTABLE | grep RPATH | awk '{print $5}' | sed -e 's/^\[//' | sed -e 's/\]$//'`
    RPATH_NEW=`echo "$RPATH_ORIG" | tr ':' '\n' | awk '{ print length, $0 }' | sort -nr | cut -d" " -f2- | tr '\n' ':' | sed -e 's/:$//'`

    # Compare length, must be equal
    if [ "${#RPATH_ORIG}" != "${#RPATH_NEW}" ]; then
	echo "ERROR: RPATH lengths do not match!"
	echo "Orig: $RPATH_ORIG"
	echo "New:  $RPATH_NEW"
	return 1
    fi

    # Patch it
    echo "INFO: Patching PHP in order to modify RPATH directory order"
    echo "Orig: $RPATH_ORIG"
    echo "New:  $RPATH_NEW"
    patchelf --set-rpath "$RPATH_NEW" $EXECUTABLE
}



###
### Clean up the environment
###
unset PNAME &&
unset PVERSION &&
unset PDIR &&
unset PFILE &&
unset PURI
