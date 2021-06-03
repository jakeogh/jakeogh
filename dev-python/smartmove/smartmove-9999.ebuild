# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Move or delete files based on dest criteria."
HOMEPAGE="https://github.com/jakeogh/smartmove"
EGIT_REPO_URI="/home/cfg/_myapps/smartmove https://github.com/jakeogh/smartmove.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/kcl[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/advisory-lock[${PYTHON_USEDEP}]
	dev-python/classify[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
