# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Pulse building library interfaceable with Tektronix AWGs 5014, 5208 and 70000A"
HOMEPAGE="https://github.com/jakeogh/broadbean"
EGIT_REPO_URI="/home/sysskel/myapps/broadbean https://github.com/jakeogh/broadbean.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/versioningit[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
