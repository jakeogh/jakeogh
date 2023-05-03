# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="testing relative imports"
HOMEPAGE="https://github.com/jakeogh/test-relative-imports"
EGIT_REPO_URI="/home/cfg/_myapps/test-relative-imports https://github.com/jakeogh/test-relative-imports.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
