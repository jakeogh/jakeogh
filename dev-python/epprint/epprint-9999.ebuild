# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1

DESCRIPTION="print() alias that writes to sys.stderr prepended by stack metadata"
HOMEPAGE="https://github.com/jakeogh/epprint"
EGIT_REPO_URI="https://github.com/jakeogh/epprint.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/eprint[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
