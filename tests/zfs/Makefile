# Tests Mk/bsd.jails.zfs.mk

JAIL_BASEPATH=	/tmp/jails
JAIL_VERSION=	test_base_jail
JAIL_NAME=	test_real_jail
ZPOOL=		zroot

DATE_FORMAT=	hello

all: test_create_basepath_clean test_create_basepath_existing \
	test_clone_dataset

test_create_basepath_clean: .PHONY
	@printf "\033[33m[test]\033[0m ${@}: "
	@${MAKE} ${JAIL_BASEPATH} > /dev/null
	@zfs list ${ZPOOL}${JAIL_BASEPATH} > /dev/null
	@${MAKE} cleanup > /dev/null
	@printf "OK\n"

cleanup: .PHONY
	@zfs destroy -rf ${ZPOOL}${JAIL_BASEPATH}

create_test_dataset: .PHONY
	@zfs create ${ZPOOL}${JAIL_BASEPATH}

test_create_basepath_existing: .PHONY
	@printf "\033[33m[test]\033[0m ${@}: "
	@${MAKE} create_test_dataset > /dev/null
	@${MAKE} ${JAIL_BASEPATH} > /dev/null
	@zfs list ${ZPOOL}${JAIL_BASEPATH} > /dev/null
	@${MAKE} cleanup > /dev/null
	@printf "OK\n"

test_clone_dataset: .PHONY
	@printf "\033[33m[test]\033[0m ${@}: "
	@${MAKE} ${JAIL_BASEPATH}/${JAIL_VERSION} > /dev/null
	@${MAKE} ${JAIL_BASEPATH}/${JAIL_NAME} > /dev/null
	@zfs list -t snap ${ZPOOL}${JAIL_BASEPATH}/${JAIL_VERSION}@hello \
		> /dev/null
	@zfs list ${ZPOOL}${JAIL_BASEPATH}/${JAIL_NAME} > /dev/null
	@${MAKE} cleanup > /dev/null
	@printf "OK\n"

.include <bsd.jails.zfs.mk>
