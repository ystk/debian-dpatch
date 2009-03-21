#!/bin/bash
# Junichi Uekawa 16 Dec 2005

##: check --with-cpp functionality.

set -e

cd $PKGPATH

echo '=== change 00list'

cat > debian/patches/00list <<EOF
01_edpatch
#if defined(DEB_BUILD_ARCH)
02_another
#endif
#if defined(SOMETHING_NOT_DEFINED)
03_description
#endif
EOF

# equivalent of dpatch-list-patch
dpatch --with-cpp cat-all 

dpatch --with-cpp cat-all | grep debian/patches/01_edpatch.dpatch 
dpatch --with-cpp cat-all | grep debian/patches/02_another.dpatch
if dpatch --with-cpp cat-all | grep debian/patches/03_description.dpatch; then
    exit 1;
else
    true
fi

echo '=== put back 00list as it was'

cat > debian/patches/00list <<EOF
01_edpatch
02_another
03_description
EOF
