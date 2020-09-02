# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7..9} )  # 6 for gentoo install

inherit distutils-r1
inherit git-r3

DESCRIPTION="Common function library"
HOMEPAGE="https://github.com/jakeogh/kcl"
EGIT_REPO_URI="/home/cfg/_myapps/kcl https://github.com/jakeogh/kcl.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/pint[${PYTHON_USEDEP}]
	dev-python/redis-py[${PYTHON_USEDEP}]
	dev-python/sqlalchemy-utils[${PYTHON_USEDEP}]
	dev-python/python-magic[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/python-getdents[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/pyperclip[${PYTHON_USEDEP}]
	sys-fs/dd-rescue
"

#	dev-python/pydot[${PYTHON_USEDEP}]
#	dev-db/sadisplay[${PYTHON_USEDEP}]
#	dev-python/pycallgraph[${PYTHON_USEDEP}]

#sys-apps/file[python]
#dev-python/python-magic[${PYTHON_USEDEP}] # file has a python flag. will that work instead?

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
