#!/bin/bash
##: Check that modifying of patch file works.
# Junichi Uekawa 19 June 2005.
set -e

cd $PKGPATH

#make sure it's unpatched
debian/rules unpatch
echo 'echo this-is-a-modified-line > one1 ' | dpatch-edit-patch 01_edpatch
debian/rules patch

echo '=== check file one1 contains the right content'
[ `cat one1` = this-is-a-modified-line ]
debian/rules unpatch

echo '=== check file one1 does not exist'
[ ! -f one1 ]


