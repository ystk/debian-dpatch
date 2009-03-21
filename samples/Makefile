top_srcdir	:= ..

include ../config.mk

SAMPLES		= sample.00template

all clean: ;

install:
	${MAKE} -C rules $@
	${MAKE} -C dpatch $@
	install -d ${DESTDIR}${sampledir}
	install -m 0644 ${SAMPLES} ${DESTDIR}/${sampledir}/

# arch-tag: e7d31caf-a56d-4006-8982-ead43c005e57
