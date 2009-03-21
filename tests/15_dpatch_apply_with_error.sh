#!/bin/bash
##: create two patches that conflict, and make sure applying both fails.

set -e

cd $PKGPATH

cat debian/patches/00list

echo 'echo one-patch > 10 ' | dpatch-edit-patch 05_conflicting1.dpatch
echo 'echo two-patch > 10 ' | dpatch-edit-patch 05_conflicting2.dpatch

cat <<EOF > debian/patches/00list
05_conflicting1
05_conflicting2
EOF

if dpatch apply-all ; then
    exit 1
else
    :
fi

dpatch deapply-all 

# make sure -v doesn't change behavior.
if dpatch apply-all -v ; then
    exit 1
else 
    :
fi
dpatch deapply-all -v 


# put them back.
cat <<EOF > debian/patches/00list
01_edpatch
02_another
03_description
EOF
