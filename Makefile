MAKESYSPATH=	/usr/share/mk:${.CURDIR}/Mk

.export MAKESYSPATH

tests: .PHONY
	${MAKE} -C tests all
