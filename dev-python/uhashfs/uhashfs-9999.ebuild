# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="A content-addressable file management system for Python"
HOMEPAGE="https://github.com/jakeogh/uhashfs"
EGIT_REPO_URI="/home/cfg/_myapps/uhashfs https://github.com/jakeogh/uhashfs.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND="
	dev-python/humanize[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/hashtool[${PYTHON_USEDEP}]
	dev-python/python-getdents[${PYTHON_USEDEP}]
	dev-python/retry-on-exception[${PYTHON_USEDEP}]
	dev-python/prettyprinter[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/unitcalc[${PYTHON_USEDEP}]
	dev-python/pathwatcher[${PYTHON_USEDEP}]
	dev-python/python-fadvise[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
"

python_install_all() {
	distutils-r1_python_install_all
}
