# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )  # keep 6 for gentoo install

inherit distutils-r1
inherit git-r3

DESCRIPTION="Replace text in file(s) or stdin."
HOMEPAGE="https://github.com/jakeogh/replace-text"
EGIT_REPO_URI="/home/cfg/_myapps/replace-text https://github.com/jakeogh/replace-text.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""
LICENSE="MIT"

DEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/enumerate_input[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
