#!/bin/bash
###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) 2012 Bostjan Skufca                                       #
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



### PHP PECL/PEAR package installation functions
php_isPackageInstalled() {
    PHP_PREFIX="$1"
    PHP_PKG_TYPE="$2"
    PHP_PKG_NAME="$3"
    RES=`$PHP_PREFIX/bin/$PHP_PKG_TYPE list | tail -n +4 | grep "^$PHP_PKG_NAME " -c | cat`
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
    php_isPackageInstalled "$PHP_PREFIX" "pecl" "$PHP_PKG_NAME"
}
php_isPackageInstalled_pear() {
    PHP_PREFIX="$1"
    PHP_PKG_NAME="$2"
    php_isPackageInstalled "$PHP_PREFIX" "pear" "$PHP_PKG_NAME"
}

php_installPackage_pecl() {
    PHP_PREFIX="$1"
    PHP_PKG_NAME_SEARCH="$2"
    PHP_PKG_NAME_INSTALL="$3"

    # If empty, search an install names are the same
    if [ "x$PHP_PKG_NAME_INSTALL" == "x" ]; then
	PHP_PKG_NAME_INSTALL="$PHP_PKG_NAME_SEARCH"
    fi
    php_isPackageInstalled_pecl "$PHP_PREFIX" "$PHP_PKG_NAME_SEARCH"
    RETVAL=$?
    if [ "$RETVAL" == "1" ]; then
	printf "\n\n\n\n\n\n\n\n\n\n" | $PHP_PREFIX/bin/pecl upgrade --force $PHP_PKG_NAME_INSTALL
	php_isPackageInstalled_pecl "$PHP_PREFIX" "$PHP_PKG_NAME_SEARCH"
        RETVAL=$?
	if [ "$RETVAL" == "1" ]; then
	    exit 6
	fi
    fi
}



unset PNAME &&
unset PVERSION &&
unset PDIR &&
unset PFILE &&
unset PURI
