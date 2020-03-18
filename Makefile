MAKESYSPATH=	/usr/share/mk:${.CURDIR}/Mk
SRCDIR=		${.CURDIR}

JAILS=
.export MAKESYSPATH SRCDIR

JAIL_COMMANDS=	fetch base_jail create_jail configure start stop

.for _jail in ${JAILS}
.	for _cmd in ${JAIL_COMMANDS}
${_jail}/${_cmd}:
	${MAKE} -C ${_jail} ${_cmd}
.	endfor
.endfor

tests: .PHONY
	${MAKE} -C tests all
