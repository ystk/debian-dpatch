VERSION=$(dpkg-parsechangelog | sed -n 's/^Version: //p')
git-tag -s -u dancer@debian.org -m "dpatch release $VERSION" $VERSION

