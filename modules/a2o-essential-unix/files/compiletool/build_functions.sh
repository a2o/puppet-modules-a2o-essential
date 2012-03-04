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

    # Download from source.a2o.si
    RES=`echo "$PURI" | grep -c 'source.a2o.si' | cat` &&
    if [ "$RES" -gt "0" ]; then
	wget -c --no-check-certificate --inet4-only --timeout=10 --tries=4 $PURI

    elif [ "`wget --help | grep -c content-disposition | cat`" -gt "0" ]; then
        wget -c --no-check-certificate --inet4-only --timeout=120 --tries=2 \
	  --content-disposition "http://source.a2o.si/source-package/?uri=$PURI"

    else
	# Older wget, does not support --content-disposition switch (1.10 for example)
	FILENAME=`echo $PURI | awk -F/ '{print $NF}'`
        wget -c --no-check-certificate --inet4-only --timeout=120 --tries=2 \
	  --output-document=$FILENAME "http://source.a2o.si/source-package/?uri=$PURI"
    fi

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
