# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Merge youtube-dl archives"
HOMEPAGE="https://github.com/jakeogh/youtubedl_merge"
EGIT_REPO_URI="/home/sysskel/myapps/youtubedl_merge https://github.com/jakeogh/youtubedl_merge.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/smartmove[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
