# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Batch Calculator for Zeolite synthesis"
HOMEPAGE="https://github.com/lmmentel/batchcalculator"
EGIT_REPO_URI="https://github.com/lmmentel/batchcalculator.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/reportlab[${PYTHON_USEDEP}]
	dev-python/wxpython[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/objectlistview[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
