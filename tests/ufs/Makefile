# Tests Mk/bsd.jails.ufs.mk

JAIL_BASEPATH=	/tmp/jails

all: test_create_basepath_clean test_create_basepath_existing

test_create_basepath_clean: .PHONY
	@printf "\033[33m[test]\033[0m ${@}: "
	@${MAKE} ${JAIL_BASEPATH} > /dev/null
	@test -d ${JAIL_BASEPATH}
	@${MAKE} cleanup > /dev/null
	@printf "OK\n"

cleanup: .PHONY
	@rm -rf ${JAIL_BASEPATH}

create_test_dataset: .PHONY
	@mkdir -p ${ZPOOL}${JAIL_BASEPATH}

test_create_basepath_existing: .PHONY
	@printf "\033[33m[test]\033[0m ${@}: "
	@${MAKE} create_test_dataset > /dev/null
	@${MAKE} ${JAIL_BASEPATH} > /dev/null
	@test -d ${JAIL_BASEPATH}
	@${MAKE} cleanup > /dev/null
	@printf "OK\n"

.include <bsd.jails.ufs.mk>

