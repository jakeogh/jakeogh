# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="distributed multiprocessing over a single job generator"
HOMEPAGE="https://github.com/jakeogh/jobdivider"
EGIT_REPO_URI="https://github.com/jakeogh/jobdivider.git"

SLOT="0"
KEYWORDS=""
IUSE=""
LICENSE="MIT"

DEPEND="
	dev-python/sympy[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
