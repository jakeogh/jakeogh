# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 git-r3

DESCRIPTION="Python context manager for or.chdir()"
HOMEPAGE="https://github.com/jakeogh/with-chdir"
EGIT_REPO_URI="/home/sysskel/myapps/with-chdir https://github.com/jakeogh/with-chdir.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

