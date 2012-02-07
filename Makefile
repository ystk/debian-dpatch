top_srcdir	= .

include config.mk

all .DEFAULT:
	${MAKE} -C compat $@
	${MAKE} -C dpatch $@
	${MAKE} -C dpep $@
	${MAKE} -C samples $@
	${MAKE} -C scripts $@

tla-release:
	mkdir dpatch-${DPATCH_REVISION}
	for file in $$(tla inventory -s | sort); do \
		install -d dpatch-${DPATCH_REVISION}/$$(dirname $$file); \
		cp -p $$file dpatch-${DPATCH_REVISION}/$$file ;\
	done
	tar cf - dpatch-${DPATCH_REVISION} | gzip -9fc >dpatch-${DPATCH_REVISION}.tar.gz
	rm -rf dpatch-${DPATCH_REVISION}

.PHONY: all

# arch-tag: d6597b23-ddec-4898-89e9-b45d313f9d1d
