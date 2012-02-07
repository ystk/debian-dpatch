#!/bin/bash
##: Check editing of patch while source has applied patches.
##: Bug: #314494
# Junichi Uekawa 19 June 2005.
set -e

cd $PKGPATH

#make sure it's patched
debian/rules patch

# make sure without --clean option, it fails.
if echo 'echo this-is-a-more-modified-line > one1 ' | dpatch-edit-patch 01_edpatch; then
    echo Unexpected success
    exit 1
else
    :
fi

# make sure --clean option works here.
echo 'echo this-is-a-more-modified-line2 > one1 ' | dpatch-edit-patch --clean 01_edpatch

debian/rules unpatch
debian/rules patch

echo '=== check file one1 contains the right content'
[ `cat one1` = this-is-a-more-modified-line2 ]
debian/rules unpatch

echo '=== check file one1 does not exist'
[ ! -f one1 ]


