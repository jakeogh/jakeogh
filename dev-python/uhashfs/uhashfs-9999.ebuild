# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="A content-addressable file management system for Python"
HOMEPAGE="https://github.com/jakeogh/uhashfs"
EGIT_REPO_URI="https://github.com/jakeogh/uhashfs.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc"

#	dev-python/prettyprinter[${PYTHON_USEDEP}]
#	dev-python/python-fadvise[${PYTHON_USEDEP}]
#	dev-python/pydantic[${PYTHON_USEDEP}]
RDEPEND="
	dev-python/humanize[${PYTHON_USEDEP}]
	dev-python/greendbtool[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/hashtool[${PYTHON_USEDEP}]
	dev-python/python-getdents[${PYTHON_USEDEP}]
	dev-python/retry-on-exception[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/unitcalc[${PYTHON_USEDEP}]
	dev-python/statustool[${PYTHON_USEDEP}]
	dev-python/signaltool[${PYTHON_USEDEP}]
	dev-python/iritool[${PYTHON_USEDEP}]
	dev-python/with-greendb[${PYTHON_USEDEP}]
	dev-python/angryfiles[${PYTHON_USEDEP}]
	dev-python/timestamptool[${PYTHON_USEDEP}]
"

python_install_all() {
	distutils-r1_python_install_all
}
