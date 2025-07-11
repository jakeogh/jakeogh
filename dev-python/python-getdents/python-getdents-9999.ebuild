# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Python binding to linux syscall getdents64"
HOMEPAGE="https://github.com/ZipFile/python-getdents"

EGIT_REPO_URI="https://github.com/jakeogh/python-getdents.git"
#EGIT_REPO_URI="https://github.com/jakeogh/python-getdents.git"
EGIT_BRANCH="attrs-bytes"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/fastentrypoints[${PYTHON_USEDEP}]
"
#	dev-python/pytest-runner[${PYTHON_USEDEP}]

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
