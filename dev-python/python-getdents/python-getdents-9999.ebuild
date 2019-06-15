# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1 git-r3

DESCRIPTION="Python binding to linux syscall getdents64"
HOMEPAGE="https://github.com/ZipFile/python-getdents"
EGIT_REPO_URI="/home/cfg/_myapps/python-getdents https://github.com/jakeogh/python-getdents"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
