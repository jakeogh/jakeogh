# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="An on-disk B+tree for Python 3"
HOMEPAGE="https://github.com/NicolasLM/bplustree"
EGIT_REPO_URI="https://github.com/NicolasLM/bplustree.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/cachetools
"


RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
