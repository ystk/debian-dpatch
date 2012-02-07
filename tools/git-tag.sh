VERSION=$(dpkg-parsechangelog | sed -n 's/^Version: //p')
git tag -s -u algernon@madhouse-project.org -m "dpatch release $VERSION" $VERSION

