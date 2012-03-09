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
# Authors: Bostjan Skufca <bostjan@a2o.si>                                #
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
	if [ "`wget --help | grep -c content-disposition | cat`" -gt "0" ]; then
    	    wget -c --no-check-certificate --inet4-only --timeout=120 --tries=2 \
	    --content-disposition "${PURI}"

	else
	    # Older wget, does not support --content-disposition switch (1.10 for example)
	    FILENAME=`echo $PURI | awk -F/ '{print $NF}'`
    	    wget -c --no-check-certificate --inet4-only --timeout=120 --tries=2 \
		--output-document=$FILENAME "${PURI}"
	fi

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



unset PNAME &&
unset PVERSION &&
unset PDIR &&
unset PFILE &&
unset PURI
