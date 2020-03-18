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
DATE_FORMAT?=	%Y-%m-%d_%H:%M:%S
BASE_JAIL_DATASET=	${ZPOOL}${JAIL_BASEPATH}/${JAIL_VERSION}

${JAIL_BASEPATH}/${JAIL_VERSION}: ${JAIL_BASEPATH} .PHONY
${JAIL_BASEPATH} ${JAIL_BASEPATH}/${JAIL_VERSION}: .PHONY
	zfs list ${ZPOOL}${@} > /dev/null 2> /dev/null || \
		zfs create ${ZPOOL}${@}

base_jail_snapshot: ${JAIL_BASEPATH}/${JAIL_VERSION}/.snapshot .PHONY

${JAIL_BASEPATH}/${JAIL_VERSION}/.snapshot: .META
	echo ${DATE_FORMAT:gmtime} > ${@}
	zfs snapshot ${BASE_JAIL_DATASET}@`cat ${@}`

${JAIL_BASEPATH}/${JAIL_NAME}: base_jail_snapshot .PHONY
	zfs list ${ZPOOL}${@} || \
		zfs clone ${BASE_JAIL_DATASET}@`cat ${JAIL_BASEPATH}/${JAIL_VERSION}/.snapshot` ${ZPOOL}${@}

.endif # ! target(__bsd.jails.zfs.mk__)
