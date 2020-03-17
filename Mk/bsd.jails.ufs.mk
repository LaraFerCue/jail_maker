# Activates the usage of UFS for the jails
#
# Variables inherited from bsd.jails.mk
# JAIL_BASEPATH
# JAIL_NAME
# JAIL_VERSION
#

.if ! target(__bsd.jails.ufs.mk__)
__bsd.jails.ufs.mk__:

${JAIL_BASEPATH} \
	${JAIL_BASEPATH}/${JAIL_VERSION} \
	${JAIL_BASEPATH}/${JAIL_NAME}: .META
	mkdir -p ${@}

.endif # ! target(__bsd.jails.ufs.mk__)
