# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="wrapper for youtube-dl"
HOMEPAGE="https://github.com/jakeogh/youtube-dl-wrapper"
EGIT_REPO_URI="/home/sysskel/myapps/youtube-dl-wrapper https://github.com/jakeogh/youtube-dl-wrapper.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/sh[${PYTHON_USEDEP}]
	net-misc/youtube-dl[${PYTHON_USEDEP}]
	dev-db/redis
	x11-misc/xclip
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/youtube-extractor[${PYTHON_USEDEP}]
	dev-python/smartmove[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	net-misc/iridb[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
