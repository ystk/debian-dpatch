#!/bin/bash
##: test dpatch editing without @DPATCH@.

set -e

cd $PKGPATH

grep -v '^@DPATCH@' debian/patches/03_description.dpatch > debian/patches/04_dpatch_test.dpatch

echo | dpatch-edit-patch 04_dpatch_test
cat debian/patches/04_dpatch_test.dpatch

echo '=== check the filename'
grep '^##.*\.dpatch by ' debian/patches/04_dpatch_test.dpatch

rm debian/patches/04_dpatch_test.dpatch
