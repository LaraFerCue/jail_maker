# Activates the usage of ZFS for the jails
# Global variables:
# ZPOOL			The name of the ZFS pool to use. Default: zroot
#
# Variables inherited from bsd.jails.mk
# JAIL_BASEPATH
# JAIL_VERSION
# JAIL_NAME
#

.if ! target(__bsd.jails.zfs.mk__)
__bsd.jails.zfs.mk__:

ZPOOL?=		zroot

${JAIL_BASEPATH} \
	${JAIL_BASEPATH}/${JAIL_VERSION} \
	${JAIL_BASEPATH}/${JAIL_NAME}: .PHONY
	zfs list ${ZPOOL}${@} > /dev/null 2> /dev/null || \
		zfs create ${ZPOOL}${@}

.endif # ! target(__bsd.jails.zfs.mk__)
