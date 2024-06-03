# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="DB backed filesystem hash index."
HOMEPAGE="https://github.com/jakeogh/pgfsindex"
EGIT_REPO_URI="https://github.com/jakeogh/pgfsindex.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	
"

	#dev-db/postgresql[${PYTHON_USEDEP}]
RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
