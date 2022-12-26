# Copyright 2016,2018-2019 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit rindeal

## functions: rpm_unpack
inherit rpm

## functions: rindeal:expand_vars
inherit rindeal-utils

## functions: systemd_dounit, systemd_newtmpfilesd, systemd_get_utildir
#inherit systemd

## functions: enewgroup, enewuser
#inherit user

DESCRIPTION="Validity Fingerprint Reader Driver"
HOMEPAGE="https://support.hp.com/in-en/drivers/selfservice/swdetails/a/5359405/swItemId/ob-203205-1"
LICENSE="HP-eula"

SLOT="0"
SRC_URI="https://ftp.hp.com/pub/softpaq/sp84501-85000/sp84530.tar"

# binaries provided by HP are for amd64 only
KEYWORDS="-* ~amd64"

## sp84530 `usr/sbin/validity-sensor`:
# 0x0000000000000001 (NEEDED)             Shared library: [libusb-0.1.so.4]
# 0x0000000000000001 (NEEDED)             Shared library: [libpthread.so.0]
# 0x0000000000000001 (NEEDED)             Shared library: [libm.so.6]
# 0x0000000000000001 (NEEDED)             Shared library: [libcrypto.so.0.9.8]
# 0x0000000000000001 (NEEDED)             Shared library: [libssl.so.0.9.8]
# 0x0000000000000001 (NEEDED)             Shared library: [libdl.so.2]
# 0x0000000000000001 (NEEDED)             Shared library: [librt.so.1]
# 0x0000000000000001 (NEEDED)             Shared library: [libusb-1.0.so.0]
# 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]

## sp84530 `usr/sbin/vcsFPService`:
# 0x0000000000000001 (NEEDED)             Shared library: [libusb-0.1.so.4]
# 0x0000000000000001 (NEEDED)             Shared library: [libpthread.so.0]
# 0x0000000000000001 (NEEDED)             Shared library: [libm.so.6]
# 0x0000000000000001 (NEEDED)             Shared library: [libcrypto.so.0.9.8]
# 0x0000000000000001 (NEEDED)             Shared library: [libssl.so.0.9.8]
# 0x0000000000000001 (NEEDED)             Shared library: [libdl.so.2]
# 0x0000000000000001 (NEEDED)             Shared library: [librt.so.1]
# 0x0000000000000001 (NEEDED)             Shared library: [libusb-1.0.so.0]
# 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]

## sp84530 `usr/lib64/libvfsFprintWrapper.so`:
# 0x0000000000000001 (NEEDED)             Shared library: [libusb-0.1.so.4]
# 0x0000000000000001 (NEEDED)             Shared library: [libpthread.so.0]
# 0x0000000000000001 (NEEDED)             Shared library: [libm.so.6]
# 0x0000000000000001 (NEEDED)             Shared library: [libcrypto.so.0.9.8]
# 0x0000000000000001 (NEEDED)             Shared library: [libssl.so.0.9.8]
# 0x0000000000000001 (NEEDED)             Shared library: [libdl.so.2]
# 0x0000000000000001 (NEEDED)             Shared library: [librt.so.1]
# 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]

DEPEND_A=(
	# required to delete rpaths pointing to upstream build dir
	"dev-util/patchelf:0"
)
RDEPEND_A=(
	# libusb-0.1.so.4
	'virtual/libusb:0'

	# libusb-1.0.so.0
	'virtual/libusb:1'

	# libcrypto.so.0.9.8
	# libssl.so.0.9.8
	'dev-libs/openssl-compat:0.9.8'

	# device discovery
	'virtual/udev'
)

RESTRICT+=" strip test mirror"

inherit arrays

## vcsFPService will run as 'validity' user.
## 'fingerprint' group is required to be able to communicate with the FP reader and
## is also used by fingerprint-gui.
VFS_USER='validity'
VFS_GROUP='fingerprint'
VFS_UMASK='0007'

src_unpack() {
	# unpack tar
	default

	rmkdir "${S}"
	rpm_unpack "${WORKDIR}"/SP*/Validity-Sensor-Setup-$(ver_cut 1-2)-$(ver_cut 3-4).x86_64.rpm "${S}"

	rcp -r "${FILESDIR}/vcsFPService_preload" "${S}/"
}

src_prepare() {
	eapply_user

	patchelf --remove-rpath usr/bin/vcsFPService usr/sbin/validity-sensor usr/lib64/libvfsFprintWrapper.so || die
}

src_compile() {
	einfo "Building preload library"
	rindeal:expand_vars vcsFPService_preload/preload.c{.in,}
	emake -C vcsFPService_preload

	local f
	for f in "${FILESDIR}"/*.in ; do
		rindeal:expand_vars "${f}" "${T}/$(basename "${f%".in"}")"
	done
}

src_install() {
	into /opt/${PN}/usr
	dolib.so usr/lib64/libvfsFprintWrapper.so
	dosbin usr/sbin/{validity-sensor,ValiditySensorEventHandler} usr/bin/vcsFPService

	# `validity-sensor` and `vcsFPService` have hardcoded paths to these `*.img` files
	insinto /usr/sbin
	doins usr/sbin/*.img

	## preload library
	insinto /usr/libexec/
	doins vcsFPService_preload/vcsFPService_preload.so

	for f in "validity-sensor" "vcsFPService" ; do
		into /usr
		newsbin \
			<(
				echo "#!/bin/sh"
				echo "export LD_PRELOAD='/usr/libexec/vcsFPService_preload.so'"
				echo "[ -e \"\${LD_PRELOAD}\" ] || { echo \"'\${LD_PRELOAD}' doesn't exist\"; exit 1; }"
				echo "exec '/opt/${PN}/usr/sbin/${f}'" '"${@}"'
			) \
			"${f}"
	done

	dodoc usr/share/doc/packages/validity/README

	## systemd files
	systemd_dounit "${T}/vcsFPService.service"
	systemd_newtmpfilesd "${FILESDIR}/vcsFPService.tmpfilesd.conf" "vcsFPService.conf"
	# TODO: periodically run this cmd to prevent the vcsFPService from flooding /tmp
	# find /tmp -maxdepth 1 -user validity -group fingerprint -regextype posix-extended -regex ".*/CH_(OUTPUT|EVENT)[0-9]+$" -delete
	exeinto "$(systemd_get_utildir)/system-sleep"
	doexe "${FILESDIR}/65-vcsFPService-SuspendResume.sh"
}

pkg_postinst() {
	[[ -z "${VFS_USER}" || -z "${VFS_GROUP}" ]] && die

	# enewgroup <group> [gid]
	enewgroup "${VFS_GROUP}"
	# enewuser <user> [uid] [shell] [homedir] [groups]
	enewuser "${VFS_USER}" -1 -1 -1 "${VFS_GROUP}"

	udev_reload
}
