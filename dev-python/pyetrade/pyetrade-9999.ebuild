# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="Python E-Trade API Wrapper"
HOMEPAGE="https://github.com/jessecooper/pyetrade"
EGIT_REPO_URI="https://github.com/jessecooper/pyetrade.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]
	dev-python/jxmlease[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
