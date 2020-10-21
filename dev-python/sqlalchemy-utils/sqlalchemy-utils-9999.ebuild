# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Various utility functions and datatypes for SQLAlchemy."
HOMEPAGE="https://github.com/kvesteri/sqlalchemy-utils"
EGIT_REPO_URI="https://github.com/kvesteri/sqlalchemy-utils.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/psycopg[${PYTHON_USEDEP}]
	"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
