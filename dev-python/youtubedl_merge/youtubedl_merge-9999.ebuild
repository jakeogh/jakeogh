# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{3_6,3_7} )

inherit distutils-r1 git-r3

DESCRIPTION="Merge youtube-dl archives"
HOMEPAGE="https://github.com/jakeogh/youtubedl_merge"
EGIT_REPO_URI="/home/cfg/_myapps/youtubedl_merge https://github.com/jakeogh/youtubedl_merge.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/kcl[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/smartmove[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
