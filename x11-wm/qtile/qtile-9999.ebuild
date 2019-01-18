# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1 virtualx

if [[ ${PV} == 9999* ]] ; then
	EGIT_REPO_URI="/home/user/_myapps/qtile https://github.com/qtile/qtile.git"
	inherit git-r3
else
	SRC_URI="https://github.com/qtile/qtile/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A full-featured, hackable tiling window manager written in Python"
HOMEPAGE="http://qtile.org/"

LICENSE="MIT"
SLOT="0"
IUSE="test"
# docs require sphinxcontrib-blockdiag and sphinxcontrib-seqdiag

RDEPEND="
	x11-libs/cairo[xcb]
	x11-libs/pango
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/cairocffi-0.7[${PYTHON_USEDEP}]
	>=dev-python/cffi-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.4.1[${PYTHON_USEDEP}]
	>=dev-python/xcffib-0.5.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/trollius[${PYTHON_USEDEP}]' 'python2*')
"
DEPEND="${RDEPEND}
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/xvfbwrapper[${PYTHON_USEDEP}]
		x11-base/xorg-server[xephyr]
		x11-apps/xeyes
		x11-apps/xcalc
		x11-apps/xclock
	)
"

# display retry backoff slowness and failures 
RESTRICT="test"

PATCHES=( "${FILESDIR}"/${PN}-0.12.0-tests.patch )

python_test() {
	# force usage of built module
	rm -rf "${S}"/libqtile || die
	PYTHONPATH="${BUILD_DIR}/lib" py.test -v "${S}"/test || die "tests failed under ${EPYTHON}"
}

#src_prepare() {
#	cp "${WORKDIR}"/scripts/ffibuild "${WORKDIR}"/libqtile/scripts/ffibuild
#	eapply_user
#}

python_install_all() {
	local DOCS=( CHANGELOG README.rst )
	distutils-r1_python_install_all

	insinto /usr/share/xsessions
	doins resources/qtile.desktop

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/${PN}-session ${PN}
	ewarn BUG: "${WORKDIR}"/"${P}"/scripts/ffibuild "${BUILDDIR}"/libqtile/scripts
	cp -v "${WORKDIR}"/"${P}"/scripts/ffibuild "${BUILDDIR}"/libqtile/scripts
}
