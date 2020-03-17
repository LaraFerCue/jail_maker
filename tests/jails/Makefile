# Tests Mk/bsd.jails.mk

all: test_fetch_tarballs test_create_base_jail

JAIL_VERSION=	resources
FTP_SERVER=	file://${.CURDIR}
FTP_PATH=

test_fetch_tarballs: .PHONY
	@printf "\033[33m[test]\033[0m ${@}: "
	@${MAKE} fetch > /dev/null 2> /dev/null
	@test -d ${TARBALLS_PATH}
	@test -r ${TARBALLS_PATH}/base.txz
	@test -r ${TARBALLS_PATH}/lib32.txz
	@rm -rf ${TARBALLS_PATH}
	@printf "OK\n"

test_create_base_jail: .PHONY
	@printf "\033[33m[test]\033[0m ${@}: "
	@${MAKE} base_jail > /dev/null 2> /dev/null
	@test -d ${JAIL_BASEPATH}/${JAIL_VERSION}
	@test -r ${JAIL_BASEPATH}/${JAIL_VERSION}/.extract
	@printf "OK\n"

.include <bsd.jails.mk>
