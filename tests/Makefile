TESTS=	zfs ufs jails


all: ${TESTS}

${TESTS}: .PHONY
	@printf "\033[35m=> Testing ${@}\033[0m\n"
	@${MAKE} -C ${.CURDIR}/${@} all
