# Tests Mk/bsd.jails.zfs.mk

JAIL_BASEPATH=	/tmp/jails
ZPOOL=		zroot

all: test_create_basepath_clean test_create_basepath_existing

test_create_basepath_clean: .PHONY
	@printf "\033[33m[test]\033[0m ${@}: "
	@${MAKE} ${JAIL_BASEPATH} > /dev/null
	@zfs list ${ZPOOL}${JAIL_BASEPATH} > /dev/null
	@${MAKE} cleanup > /dev/null
	@printf "OK\n"

cleanup: .PHONY
	@zfs destroy ${ZPOOL}${JAIL_BASEPATH}

create_test_dataset: .PHONY
	@zfs create ${ZPOOL}${JAIL_BASEPATH}

test_create_basepath_existing: .PHONY
	@printf "\033[33m[test]\033[0m ${@}: "
	@${MAKE} create_test_dataset > /dev/null
	@${MAKE} ${JAIL_BASEPATH} > /dev/null
	@zfs list ${ZPOOL}${JAIL_BASEPATH} > /dev/null
	@${MAKE} cleanup > /dev/null
	@printf "OK\n"

.include <bsd.jails.zfs.mk>
