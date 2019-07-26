# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1 git-r3

DESCRIPTION="Python binding to linux syscall getdents64"
HOMEPAGE="https://github.com/ZipFile/python-getdents"
#EGIT_REPO_URI="https://github.com/ZipFile/python-getdents.git"

EGIT_REPO_URI="/home/cfg/_myapps/python-getdents https://github.com/jakeogh/python-getdents"
#BRANCH="yield-objects"
#BRANCH="attrs"
BRANCH="attrs-Dent"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/pytest-runner[${PYTHON_USEDEP}]
	dev-python/fastentrypoints[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
