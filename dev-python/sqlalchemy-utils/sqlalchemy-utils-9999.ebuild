# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

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
