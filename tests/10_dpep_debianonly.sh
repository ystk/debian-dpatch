#!/bin/bash
# Junichi Uekawa 11 Jul 2005.
##: Check that --debianonly option is working in dpatch-edit-patch

set -ex

# uses debianonly/
# debianonly/upstream directory for tar.gz
# debianonly/dpatch-test/debian directory for debian directory.

cd $PKGPATH/..
mkdir debianonly
mkdir debianonly/upstream
mkdir debianonly/dpatch-test

# create the orig.tar.gz and a debian directory
cp -r $PKGPATH/debian debianonly/dpatch-test
tar cfz debianonly/upstream/dpatch-test_0.1.orig.tar.gz dpatch-test

cd debianonly/dpatch-test

# try running dpatch-edit-patch with full path to the orig.tar.gz
echo 'echo another-patch > 10 ' | dpatch-edit-patch --debianonly=../upstream/dpatch-test_0.1.orig.tar.gz -d test 10_test_patch

##: Also try checking that given a wrong full path, it will error out.; 
##: message fixed in 317758
if echo 'echo even more > 10 ' | dpatch-edit-patch --debianonly=../upstream/dpatch-test_0.1.orig.tar.gz- -d test 10_test_patch; then
    echo Wrong-path test failed!
    exit 1
else
    echo success
fi

#cat debian/patches/10_test_patch.dpatch
grep "another-patch" debian/patches/10_test_patch.dpatch
