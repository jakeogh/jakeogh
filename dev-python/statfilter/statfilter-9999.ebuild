# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Filter files from stdin to stdout based on stat(1)"
HOMEPAGE="https://github.com/jakeogh/statfilter"
EGIT_REPO_URI="https://github.com/jakeogh/statfilter.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
"

DEPEND="${RDEPEND}"
