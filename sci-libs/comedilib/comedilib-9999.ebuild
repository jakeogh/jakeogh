# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# https://raw.githubusercontent.com/Jannis234/jm-overlay/master/sci-libs/comedilib/comedilib-0.10.2-r1.ebuild

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit linux-info python-single-r1 multilib-minimal git-r3 autotools eutils

DESCRIPTION="Linux control and measurement device interface (userspace libraries)"
HOMEPAGE="http://www.comedi.org/"
EGIT_REPO_URI="https://github.com/Linux-Comedi/comedilib.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="doc static-libs python udev firmware pdf scxi"

RDEPEND="udev? ( virtual/udev )
	python? ( ${PYTHON_DEPS} )
	firmware? ( !sys-kernel/linux-firmware[-savedconfig] )"
DEPEND="${RDEPEND}
	doc? ( app-text/xmlto )
	python? ( dev-lang/swig )"
REQUIRED_USE="pdf? ( doc )
	python? ( ${PYTHON_REQUIRED_USE} )"

CONFIG_CHECK="COMEDI"

src_prepare() {
	eapply_user
	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable static-libs static) \
		$(use_enable firmware) \
		$(use_enable scxi) \
		$(use_enable doc docbook) \
		$(use_with pdf pdf-backend default) \
		$(use_with udev udev-hotplug "${EPREFIX}/lib") \
		$(use_enable python python-binding)
}

multilib_src_install() {
	default
	use python && python_optimize
}

multilib_src_install_all() {
	cd "${S}"
	dodoc INSTALL AUTHORS ChangeLog NEWS README
}
