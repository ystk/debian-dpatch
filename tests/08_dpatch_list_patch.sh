#!/bin/bash
# Junichi Uekawa 11 Jul 2005.

##: check dpatch-list-patch works.
##: Depends on 06,07.

set -e

cd $PKGPATH


echo '=== output of dpatch-list-patch'
dpatch-list-patch

echo '=== check for obvious entries in output of dpatch-list-patch'
dpatch-list-patch | grep debian/patches/01_edpatch.dpatch
dpatch-list-patch | grep "No description"
dpatch-list-patch | grep debian/patches/03_description.dpatch
dpatch-list-patch | grep "Description of this patch"


##: Also, run dpatch-edit-patch with -d option, and check that
##: -d only has effect on newly created patches


echo '=== Edit patch with an attempt for changed description'
#make sure it's unpatched
debian/rules unpatch
echo 'echo 08 > desc ' | \
    dpatch-edit-patch -d '08 Changed description' 03_description

echo '=== Make sure dpatch-list-patch picks up the new description'
dpatch-list-patch
if dpatch-list-patch | grep "08 Changed description"; then
    echo "This should not come here."
    exit 1
else
    :
fi

dpatch-list-patch | grep "Description of this patch"
