# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="lookup usb tty device path by device id"
HOMEPAGE="https://github.com/jakeogh/usbtool"
EGIT_REPO_URI="https://github.com/jakeogh/usbtool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/serialtool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
