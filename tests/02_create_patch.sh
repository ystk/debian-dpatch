#!/bin/bash
##: check generation of initial patch
##: Bug#321320: also check the generated patch file
# Junichi Uekawa 19 June 2005, updated 6 Aug 2005.
set -e

cd $PKGPATH

echo 'echo this-is-a-line > one1 ' | dpatch-edit-patch 01_edpatch
echo 01_edpatch > debian/patches/00list
debian/rules patch

echo '=== check file one1 contains the right content'
[ `cat one1` = this-is-a-line ]
debian/rules unpatch

echo '=== check file one1 does not exist'
[ ! -f one1 ]

# additional checks; try creating a patch file.
echo "cp -p ${SOURCE_DIR}/02_create_patch.sh . " | dpatch-edit-patch 02_create_two
cp debian/patches/02_create_two.dpatch{,~~}
echo "exit 0" | dpatch-edit-patch 02_create_two

# 'patch' will update the timestamp. The following command 
# should output '11', not 0.

if diff -u debian/patches/02_create_two.dpatch{~~,} > /dev/null; then
    :
else
    echo 'diff gives zero output; date should have changed'
    cat  debian/patches/02_create_two.dpatch{~~,}
fi
