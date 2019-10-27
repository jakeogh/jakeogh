# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{3_6,3_7} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Sweet and creamy print debugging."
HOMEPAGE="https://github.com/gruns/icecream"
EGIT_REPO_URI="https://github.com/gruns/icecream.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/untokenize[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/executing[${PYTHON_USEDEP}]
	dev-python/asttokens[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
