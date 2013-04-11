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
#
# ACT installer
#
# ACT = a2o Compile Tool
#
# This is the initial embryo of what is hoped will once become a fully-
# featured server software installer.
#



################################################################################
###
### ACT methods - new way of building/installing packages
###
################################################################################

###
### Output and error handling subroutines
###
function _act_echo() {
    echo "ACT: $1"
}
function _act_echo_n() {
    echo -n "ACT: $1"
}
function _act_echo_raw() {
    echo "$1"
}

function _act_info() {
    echo "INFO: $1"
}
function _act_warning() {
    echo "WARNING: $1"
}

function _act_error_fatal() {
    MSG="$1"

    echo
    echo
    echo "ERROR: $MSG"
    echo
    exit 1
}
function _act_fatalError() {
    _act_error_fatal "$1"
}



###
### Initialize ACT
###
function _act_init() {

    # Default configuration
    export ACT_DOWNLOAD_PROXY_URI=''
    export ACT_DOWNLOAD_PROXY_EXCEPTION_REGEX='UNDEFINED'
    export ACT_DEBUG='false'   # TODO

#    # Source main configuration file
#    if [ ! -f /etc/act/act.conf ]; then
#	_act_fatalError "Main configuration file does not exist: /etc/act/act.conf"
#    fi
#    source /etc/act/act.conf

    # Source files from configuration directory
    if [ -d /etc/act/conf.d ]; then
	for FILE in `ls /etc/act/conf.d`; do
	    source /etc/act/conf.d/$FILE
	done
    fi

    # Remove trailing slash from proxy URI
    export ACT_DOWNLOAD_PROXY_URI=`echo "$ACT_DOWNLOAD_PROXY_URI" | sed -e 's#/$##'`

    # Misc variables and values
    export SUCCESS=0
    export FAILURE=255

    # Get wget version - do not export at the beginning because subsequent if
    # clause does not detect error from backticks
    ACT_WGET_VERSION=`wget --version | head -n1 | cut -d' ' -f3 | sed -e 's/\.//'`   #
    if [ "$?" != "0" ]; then
	_act_fatalError "Unable to get wget version"
    fi
    export ACT_WGET_VERSION

    # Check the environment - TODO
}



###
### DOWNLOAD FILE: Directly from URI
###
### If file already exists, verify it's md5 hash and act accordingly
###
function _act_downloadFile_fromUri() {
    URI="$1"
    FILENAME=`echo "$URI" | awk -F/ '{print $NF}'`

    rm -f $FILENAME
    _act_echo_n "Downloading from ${URI}... "
    wget -q --no-check-certificate --inet4-only --timeout=120 --tries=2 --output-document=$FILENAME "${URI}"
    if [ "$?" != "0" ]; then
	_act_fatalError "Unable to download from proxy: ${PROXIED_URI_FILE}"
    fi
    _act_echo_raw "done."
}



###
### DOWNLOAD FILE: Through proxy
###
function _act_downloadFile_fromProxy() {
    URI="$1"
    FILENAME=`echo "$URI" | awk -F/ '{print $NF}'`
    PROXIED_URI_FILE="${ACT_DOWNLOAD_PROXY_URI}/get/source-package/?uri=${URI}"
    PROXIED_URI_MD5="${ACT_DOWNLOAD_PROXY_URI}/get/source-package-md5/?uri=${URI}"

    # If download is from the proxy itself
    ACT_PROXY_HOSTNAME=`echo $ACT_DOWNLOAD_PROXY_URI  | cut -d'/' -f3`
    RES=`echo "$URI" | fgrep -c "$ACT_PROXY_HOSTNAME" | cat`
    if [ "$RES" -gt "0" ]; then
	_act_downloadFile_fromUri "$URI"
	return $?
    fi

    # If download is from the proxy exception list
    RES=`echo "$URI" | grep -c "$ACT_DOWNLOAD_PROXY_EXCEPTION_REGEX" | cat`
    if [ "$RES" -gt "0" ]; then
	_act_downloadFile_fromUri "$URI"
	return $?
    fi

    # If file exist, check md5 and exit if matches
    if [ -e $FILENAME ]; then
	_act_echo "File already exist: $FILENAME"

	if [ ! -f $FILENAME ]; then
	    _act_fatalError "Not a regular file: $FILENAME (from $URI)"
	fi

	_act_echo_n "Verifying MD5 of $FILENAME... "
	FILENAME_MD5=$(_act_calculateFileMd5 $FILENAME)
	URI_MD5=$(_act_downloadMd5_fromProxy "$URI")
	if [ "$FILENAME_MD5" == "$URI_MD5" ]; then
	    _act_echo_raw "matches. ($FILENAME_MD5)"
	    return 0   # md5s match, return successful file retrieval
	fi

	_act_echo_raw ""
	_act_warning "MD5 sums of file $FILENAME do not match: file=$FILENAME_MD5, uri=$URI_MD5"
	_act_info "Removing file and proceeding with normal download from proxy"
	# Remove or continue download? FIXME THINK TODO
	rm -f $FILENAME
    fi

    ### DOWNLOAD
#    if [ "`wget --help | grep -c content-disposition | cat`" -gt "0" ]; then
#        wget -c --no-check-certificate --inet4-only --timeout=120 --tries=2 \
#	    --content-disposition "${ACT_DOWNLOAD_PROXY_URI}${URI}"
#    else

    # Older wget, does not support --content-disposition switch (1.10 for example)
    _act_echo_n "Downloading from ${PROXIED_URI_FILE}... "
#    wget $ACT_DEBUG --no-check-certificate --inet4-only --timeout=120 --tries=2 \
    wget -q --no-check-certificate --inet4-only --timeout=120 --tries=2 \
	--output-document=$FILENAME "${PROXIED_URI_FILE}"
    if [ "$?" != "0" ]; then
	_act_fatalError "Unable to download from proxy: ${PROXIED_URI_FILE}"
    fi
    _act_echo_raw "done."

    ### CHECK MD5
    _act_echo_n "Verifying MD5 of $FILENAME... "
    FILENAME_MD5=$(_act_calculateFileMd5 $FILENAME)
    URI_MD5=$(_act_downloadMd5_fromProxy "$URI")
    if [ "$FILENAME_MD5" == "$URI_MD5" ]; then
	_act_echo_raw "matches. ($FILENAME_MD5)"
	return 0
    fi

    _act_fatalError "MD5 sums of file $FILENAME do not match: file=$FILENAME_MD5, uri=$URI_MD5"
}



###
### DOWNLOAD FILE: Through proxy
###
function _act_downloadFile() {
    URI="$1"

    if [ "x$ACT_DOWNLOAD_PROXY_URI" != "x" ]; then
	_act_downloadFile_fromProxy "$PURI"
    else
	_act_downloadFile_fromUri "$PURI"
    fi
}



###
### DOWNLOAD MD5 HASH OF A FILE: From proxy
###
function _act_downloadMd5_fromProxy() {
    URI="$1"
    PROXIED_URI_MD5="${ACT_DOWNLOAD_PROXY_URI}/get/source-package-md5/?uri=${URI}"

    MD5=`wget --no-check-certificate --inet4-only --timeout=120 --tries=2 --output-document=- -q "${PROXIED_URI_MD5}"`
    if [ "$?" != "0" ]; then
	_act_fatalError "Unable to download MD5 from proxy: ${PROXIED_URI_MD5}"
    fi

    echo $MD5
}



###
### Calculate MD5 hash of a file content, and return it
###
function _act_calculateFileMd5() {
    FILE="$1"
    if [ ! -e $FILE ]; then
	_act_fatalError "File does not exist: $FILE"
    fi
    if [ ! -f $FILE ]; then
	_act_fatalError "Not a regular file: $FILE"
    fi

    MD5=`md5sum $FILE | cut -d' ' -f1`
    if [ "$?" != "0" ]; then
	_act_error_fatal "Unable to calculate md5 hash of a file: $FILE"
    fi

    echo $MD5
}



################################################################################
###
### OLDER METHODS, now slowly being phased out and rewritten
###
################################################################################

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

    _act_downloadFile "$PURI"
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
    RPATH_ORIG=`readelf -d $EXECUTABLE | grep RPATH | awk '{print $5}' | sed -e 's/^\[//' | sed -e 's/\]$//'`
    RPATH_NEW=`echo "$RPATH_ORIG" | tr ':' '\n' | awk '{ print length, $0 }' | sort -nr | cut -d" " -f2- | tr '\n' ':' | sed -e 's/:$//'`

    # Check if nonempty
    if [ "$RPATH_ORIG" == "" ]; then
	echo "ERROR: RPATH empty or not set!"
	return 1
    fi

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
### Clean up the environment and initialize
###
unset PNAME &&
unset PVERSION &&
unset PDIR &&
unset PFILE &&
unset PURI &&
_act_init
