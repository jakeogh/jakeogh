# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="stdin/stdout functions"
HOMEPAGE="https://github.com/jakeogh/stdiotool"
EGIT_REPO_URI="https://github.com/jakeogh/stdiotool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
