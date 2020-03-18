# A module to create jails in a really simple way.
#
# The goal is to create jails in the same way the ports in FreeBSD are built
# Global variables that can be configured in make.conf:
# JAIL_BASEPATH			The path where all the jails are going to be
#				stored. Default: /usr/jails
# USE_ZFS			Use ZFS for the jails. Default: yes
# FTP_SERVER			The server where the tarballs are fetched
# 				from. Default: ftp://ftp.FreeBSD.org
# FTP_PATH			Path inside the server to fetch the sources.
# 				Default: pub/FreeBSD/releases/${ARCH}/${ARCH}
#
# Local variables (defined per jail):
# JAIL_NAME			Name of the jail to create.
# JAIL_VERSION			The FreeBSD version to install in the jail.

.if ! target(__bsd.jails.mk__)
__bsd.jails.mk__:

USE_ZFS?=	YES
JAIL_BASEPATH?=	/usr/jails
FTP_SERVER?= 	ftp://ftp.FreeBSD.org
ARCH?=		`uname -m`
FTP_PATH?=	pub/FreeBSD/releases/${ARCH}/${ARCH}

.if ${USE_ZFS} != YES
.include <bsd.jails.ufs.mk>
.else
.include <bsd.jails.zfs.mk>
.endif

TARBALLS_PATH=	${JAIL_BASEPATH}/tarballs/${JAIL_VERSION}

fetch: ${TARBALLS_PATH} ${TARBALLS_PATH}/base.txz ${TARBALLS_PATH}/lib32.txz .PHONY

${TARBALLS_PATH}/base.txz ${TARBALLS_PATH}/lib32.txz: .META
	fetch -o ${@} ${FTP_SERVER}/${FTP_PATH}/${JAIL_VERSION}/${@:T}

${TARBALLS_PATH}: ${JAIL_BASEPATH}/tarballs
${JAIL_BASEPATH}/tarballs: ${JAIL_BASEPATH}
${JAIL_BASEPATH}/tarballs ${TARBALLS_PATH}:
	mkdir -p ${@}

base_jail: fetch ${JAIL_BASEPATH}/${JAIL_VERSION} extract_tarballs .PHONY

.if ${JAIL_VERSION:M*-RELEASE} != ""
base_jail: update_base_jail
.endif

extract_tarballs: ${JAIL_BASEPATH}/${JAIL_VERSION}/.extract .PHONY

${JAIL_BASEPATH}/${JAIL_VERSION}/.extract:
	@echo "-> Extract base.txz into ${JAIL_BASEPATH}/${JAIL_VERSION}"
	tar -xf ${TARBALLS_PATH}/base.txz -C ${JAIL_BASEPATH}/${JAIL_VERSION}
	@echo "-> Extract lib32.txz into ${JAIL_BASEPATH}/${JAIL_VERSION}"
	tar -xf ${TARBALLS_PATH}/lib32.txz -C ${JAIL_BASEPATH}/${JAIL_VERSION}
	@touch ${@}

update_base_jail: .PHONY .SILENT .IGNORE
	env PAGER=cat freebsd-update --currently-running ${JAIL_VERSION} \
		-b ${JAIL_BASEPATH}/${JAIL_VERSION} fetch
	freebsd-update --currently-running ${JAIL_VERSION} \
		-b ${JAIL_BASEPATH}/${JAIL_VERSION} install
.endif # ! target(__bsd.jails.mk__)
