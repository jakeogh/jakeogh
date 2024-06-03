# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Common functions for working with IRI's and URI's"
HOMEPAGE="https://github.com/jakeogh/iritool"
EGIT_REPO_URI="https://github.com/jakeogh/iritool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/urltool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
