#!/bin/bash
# Junichi Uekawa 11 Jul 2005, modified 16 Jul 2005.
##: Check that --debianonly option is working in dpatch-edit-patch
##: with the auto-detection, finding the .tar.gz in ../upstream directory.
##: Bug: #315719 -- patch to use ../upstream
##: Depends on 10_dpep_debianonly.sh for setting up the environment.
##: Bug: #317775 -- fallback when orig.tar.gz does not exist does not work.

set -ex

# uses debianonly/
# debianonly/upstream directory for tar.gz
# debianonly/dpatch-test/debian directory for debian directory.

cd $PKGPATH/../debianonly/dpatch-test

mv ../upstream ../hidden-upstream
# Error out if given wrong upstream orig.tar.gz path.
if echo 'echo yet-more-patch > 11 ' | dpatch-edit-patch -P$(pwd)/../upstream --debianonly -d test 11_test_patch; then
    echo "exit with error expected, upstream not found for this package"
    exit 1
else
    :
fi


mv ../hidden-upstream ../upstream
# Give proper upstream orig.tar.gz path, should succeed
echo 'echo yet-more-patch > 11 ' | dpatch-edit-patch -P$(pwd)/../upstream --debianonly -d test 11_test_patch

# Give proper upstream orig.tar.gz path, should succeed
echo 'echo yet-more-patch > 11 ' | dpatch-edit-patch --origtargzpath=$(pwd)/../upstream --debianonly -d test 11_test_patch

# check the resulting dpatch file.
#cat debian/patches/11_test_patch.dpatch
grep yet-more-patch debian/patches/11_test_patch.dpatch
