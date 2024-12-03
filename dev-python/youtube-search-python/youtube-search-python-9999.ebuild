# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Get YouTube video information using link WITHOUT YouTube Data API v3"
HOMEPAGE="https://github.com/jakeogh/youtube-search-python"
EGIT_REPO_URI="/home/sysskel/myapps/youtube-search-python https://github.com/jakeogh/youtube-search-python.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/httpx[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
