# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} )
PYTHON_REQ_USE="ncurses"

inherit distutils-r1
inherit git-r3

DESCRIPTION="Curses-based user interface library for Python"
HOMEPAGE="http://urwid.org/ https://pypi.org/project/urwid/"
EGIT_REPO_URI="https://github.com/urwid/urwid.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="doc examples"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
"

python_compile_all() {
	if use doc; then
		sphinx-build docs _build/html || die
	fi
}

python_compile() {
	if ! python_is_python3; then
		local CFLAGS="${CFLAGS} -fno-strict-aliasing"
		export CFLAGS
	fi

	distutils-r1_python_compile
}

python_test() {
	esetup.py test
}

python_install_all() {
	use examples && dodoc -r examples
	use doc && local HTML_DOCS=( _build/html/. )

	distutils-r1_python_install_all
}
