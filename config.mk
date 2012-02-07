# -*- Makefile -*-
# configuration options for the dpatch makefiles

DPATCH_REVISION	= $(shell cd ${top_srcdir}; dpkg-parsechangelog | \
			  grep "^Version: " | sed -e "s,^Version: ,,")

prefix		= /usr
sysconfdir	= /etc
exec_prefix	= ${prefix}
bindir		= ${exec_prefix}/bin
datadir		= ${prefix}/share
pkgdatadir	= ${datadir}/dpatch
mandir		= ${datadir}/man
man1dir		= ${mandir}/man1
man7dir		= ${mandir}/man7
docdir		= ${datadir}/doc/dpatch
sampledir	= ${docdir}/examples

# arch-tag: 6822d126-9fd3-4ea3-949c-e29c6801b122
