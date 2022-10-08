# Copyright 1999-2022 Gentoo Authors
# Copyright 2016-2020 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit rindeal

## EXPORT_FUNCTIONS: src_unpack
inherit vcs-snapshot

## functions: append-cppflags
inherit flag-o-matic

## functions: get_udevdir, udev_reload
inherit udev

## EXPORT_FUNCTIONS: src_configure src_compile src_test src_install
inherit meson

## functions: enewgroup
inherit user

DESCRIPTION="Library for fingerprint reader support"
HOMEPAGE="https://cgit.freedesktop.org/${PN}/${PN}"
LICENSE="LGPL-2.1"

# NOTE: upstream changes case of the 'v' letter from time to time
MY_PV="V_${PV//./_}"
vfs_proprietary_ref="v0.9.0"

SLOT="0"
SRC_URI_A=(
	"https://gitlab.freedesktop.org/${PN}/${PN}/-/archive/${MY_PV}/${P}.tar.bz2"
	"vfs_proprietary-driver? ("
		"https://github.com/rindeal/libfprint-vfs_proprietary-driver/archive/${vfs_proprietary_ref}.tar.gz -> vfs_proprietary-driver-${vfs_proprietary_ref}.tar.gz"
	")"
)

# no arm until profiles are set up
KEYWORDS="~amd64"
IUSE_A=( doc examples vfs_proprietary-driver )

CDEPEND_A=(
	"virtual/libusb:1"
	"dev-libs/glib:2"
	"dev-libs/nss"
	"x11-libs/pixman"
	"virtual/udev"
	"examples? ("
		"x11-libs/libX11:0"
		"x11-libs/libXv:0"
		"x11-libs/gtk+:3"
	")"
)
DEPEND_A=( "${CDEPEND_A[@]}"
	"virtual/pkgconfig"
)
RDEPEND_A=( "${CDEPEND_A[@]}"
	"amd64? ( vfs_proprietary-driver? ( sys-auth/validity-sensor ) )"
)

RESTRICT+=" mirror"

inherit arrays

FP_GROUP='fingerprint'

src_unpack() {
	vcs-snapshot_src_unpack

	rmv vfs_proprietary-driver*/vfs_proprietary "${S}"/libfprint/drivers
	append-cppflags "-DVFS_PROPRIETARY_TRACE"
}

src_prepare() {
	eapply_user

	## set fp usb dev permissions, this is what Debian does
	rsed -e "\|ATTR{power/control}|r"<(
			echo 'printf ("SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"%04x\", ATTRS{idProduct}==\"%04x\", ",'
			echo '            driver->id_table[i].vendor, driver->id_table[i].product);'
			echo 'printf ("MODE=\"0664\", ");'
			echo "printf (\"GROUP=\\\"${FP_GROUP}\\\"\");"
			echo 'printf ("\n");'
		) -i -- libfprint/fprint-list-udev-rules.c

	if use vfs_proprietary-driver ; then
		local driver_name="vfs_proprietary"

		rsed -e "/^all_drivers *=/a all_drivers += [ '${driver_name}' ]" -i -- meson.build
		rsed -e "/^libfprint *=/i subdir('drivers/${driver_name}')" -i -- libfprint/meson.build
	fi

	use examples || rsed -e "/subdir('examples')/d" -i -- meson.build
}

src_configure() {
	local emesonargs=(
		# TODO: split to USE=all-drivers / USE=<driver> ...
		-D drivers=all
		-D udev_rules=true  # Whether to create a udev rules file
		-D udev_rules_dir="$(get_udevdir)/rules.d"
		$(meson_use examples x11-examples)
		$(meson_use examples gtk-examples)
		$(meson_use doc)  # Whether to build the API documentation
	)

	meson_src_configure
}

pkg_postinst() {
	# enewgroup <group> [gid]
	enewgroup "${FP_GROUP}"

	elog "To use fingerprint readers user has to be a member of the '${FP_GROUP}' group."

	udev_reload
}
