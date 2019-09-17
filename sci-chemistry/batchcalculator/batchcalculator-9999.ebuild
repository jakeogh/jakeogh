# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Batch Calculator for Zeolite synthesis"
HOMEPAGE="https://github.com/lmmentel/batchcalculator"
EGIT_REPO_URI="https://github.com/lmmentel/batchcalculator.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/numpy
	dev-python/sqlalchemy
	dev-python/reportlab
	dev-python/wxpython
	dev-python/six
	dev-python/objectlistview
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
