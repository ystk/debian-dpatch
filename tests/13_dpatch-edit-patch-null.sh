#!/bin/bash
# Junichi Uekawa 16 Dec 2005

##: check dpatch-edit-patch without command-line options.

set -e

cd $PKGPATH

echo '=== dpatch-edit-patch with NULL command-line option'
if echo | dpatch-edit-patch ; then
    exit 1;
else
    true
fi

if [ -f debian/patches/.dpatch ]; then
    exit 1;
else
    true
fi
