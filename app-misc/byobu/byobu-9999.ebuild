# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit python-single-r1
inherit git-r3

DESCRIPTION="A set of profiles for the GNU Screen console window manager (app-misc/screen)"
HOMEPAGE="http://byobu.co"
EGIT_REPO_URI="https://github.com/dustinkirkland/byobu.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="screen"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-libs/newt[${PYTHON_USEDEP}]
	screen? ( app-misc/screen )
	!screen? ( app-misc/tmux )"

src_prepare() {
	default

	python_fix_shebang .

	# Set default system backend to screen
	if use screen ; then
		sed -i -e 's/#\(BYOBU_BACKEND\).*/\1="screen"/' etc/byobu/backend || die
	fi
}

src_install() {
	default

	# Create symlinks for backends
	dosym ${PN} /usr/bin/${PN}-screen
	dosym ${PN} /usr/bin/${PN}-tmux

	docompress -x /usr/share/doc/${PN}
}
