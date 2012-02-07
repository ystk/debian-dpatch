top_srcdir	:= ../..

include ../../config.mk

SAMPLES		= rules.dh rules.non-dh rules.new.dh rules.new.non-dh \
		00list.new.non-dh rules.dh7

all clean: ;

install:
	install -d ${DESTDIR}${sampledir}/rules
	install -m 0644 ${SAMPLES} ${DESTDIR}/${sampledir}/rules/

# arch-tag: c13082da-1c0a-4a33-a965-464b133e7985
