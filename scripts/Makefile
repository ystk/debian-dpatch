top_srcdir	:= ..

include ../config.mk

all clean: ;

install:
	install --mode 0755 dpatch-convert-diffgz ${DESTDIR}${bindir}/
	install --mode 0644 dpatch-convert-diffgz.1 ${DESTDIR}${man1dir}/
	install --mode 0755 dpatch-list-patch ${DESTDIR}${bindir}/
	install --mode 0644 dpatch-list-patch.1 ${DESTDIR}${man1dir}/

# arch-tag: 300ce63b-4d2e-4e55-8b36-720122051d35
