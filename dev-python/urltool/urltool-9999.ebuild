# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=(python3_{11..13})

inherit git-r3
inherit distutils-r1

DESCRIPTION="Common functions for manipulating url/iris"
HOMEPAGE="https://github.com/jakeogh/urltool"
EGIT_REPO_URI="https://github.com/jakeogh/urltool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/urlextract[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
