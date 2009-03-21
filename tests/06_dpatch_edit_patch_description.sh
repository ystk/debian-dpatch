#!/bin/bash
# Junichi Uekawa 21 June 2005.

##: check to see if '-d' command-line option works at all.
##: This didn't work in 2.0.13, since 'dpatch_template_hardcoded' doesn't call 'dpatch' with the description.

set -e

cd $PKGPATH

#make sure it's unpatched
debian/rules unpatch
echo 'echo Modification > desc ' | \
    dpatch-edit-patch -d 'Description of this patch' 03_description
echo 03_description >> debian/patches/00list
debian/rules patch

echo '=== check file contains the right content'
[ `cat desc` = Modification ]
debian/rules unpatch

echo '=== check file does not exist'
[ ! -f desc ]

echo '=== check the description'
grep 'Description of this patch' debian/patches/03_description.dpatch

echo '=== check the filename'
grep '^##.*\.dpatch by ' debian/patches/03_description.dpatch

