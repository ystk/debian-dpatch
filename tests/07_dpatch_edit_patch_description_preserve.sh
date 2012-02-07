#!/bin/bash
# Junichi Uekawa 21 June 2005.

##: check to see the description set in 06 is preserved.
##: after editing.

set -e

cd $PKGPATH

#make sure it's unpatched
debian/rules unpatch
echo 'echo Another Modification > desc ' | \
    dpatch-edit-patch 03_description
debian/rules patch

echo '=== check file contains the right content'
[ "`cat desc`" = 'Another Modification' ]
debian/rules unpatch

echo '=== check file does not exist'
[ ! -f desc ]

echo '=== check the description'
grep 'Description of this patch' debian/patches/03_description.dpatch
