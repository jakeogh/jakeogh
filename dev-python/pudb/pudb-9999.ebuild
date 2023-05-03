# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="A full-screen, console-based Python debugger"
HOMEPAGE="https://pypi.python.org/pypi/pudb"
EGIT_REPO_URI="https://github.com/inducer/pudb.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/urwid[${PYTHON_USEDEP}]
	dev-python/urwid_readline[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest-mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
