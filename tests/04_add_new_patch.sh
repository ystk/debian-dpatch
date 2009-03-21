#!/bin/bash
##: Check new patch addition works.
# Junichi Uekawa 19 June 2005.
set -e

cd $PKGPATH

debian/rules unpatch
echo 'echo another-patch > one2 ' | dpatch-edit-patch 02_another 01_edpatch
echo 02_another >> debian/patches/00list

debian/rules patch
echo '=== check file one2 contains the right content'
[ `cat one2` = another-patch ]
[ `cat one1` = this-is-a-modified-line ]

debian/rules unpatch
echo '=== check file one2 does not exist'
[ ! -f one2 ]
[ ! -f one1 ]
