# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="read stats from the Kimball Physics igps-1101a ion gun power supply"
HOMEPAGE="https://github.com/jakeogh/gpib-ion-gun-igps1101a"
EGIT_REPO_URI="https://github.com/jakeogh/gpib-ion-gun-igps1101a.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"


