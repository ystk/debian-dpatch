top_srcdir	:= ..

DPATCH_SRCS	:= $(shell sed -n s/^\#:include//p dpatch.shpp)

include ../config.mk

all: dpatch dpatch-run dpatch.lib.sh

dpatch: dpatch.shpp ../debian/changelog ${DPATCH_SRCS}

	DPATCH_REVISION="${DPATCH_REVISION}" \
	  SYSCONFDIR="${sysconfdir}" ../tools/shpp.awk <dpatch.shpp >dpatch
	chmod +x dpatch

dpatch-run: dpatch-run.shpp
	../tools/shpp.awk <dpatch-run.shpp >dpatch-run

dpatch.lib.sh: dpatch.lib.shpp
	../tools/shpp.awk <dpatch.lib.shpp >dpatch.lib.sh

clean:
	rm -f dpatch dpatch-run dpatch.lib.sh

install: all
	install --mode 0755 dpatch ${DESTDIR}${bindir}/
	install --mode 0644 dpatch.1 ${DESTDIR}${man1dir}/
	install --mode 0644 dpatch.7 ${DESTDIR}${man7dir}/
	install --mode 0644 dpatch-run ${DESTDIR}${pkgdatadir}/
	install --mode 0644 dpatch.lib.sh ${DESTDIR}${pkgdatadir}/

.PHONY: all clean install
.SUFFIXES:

# arch-tag: ae9d044e-94e2-4692-9a3d-fbff280e147e
