# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 git-r3

DESCRIPTION="A content-addressable file management system for Python"
HOMEPAGE="https://github.com/dgilland/hashfs"
#EGIT_REPO_URI="https://github.com/dgilland/hashfs.git"
EGIT_REPO_URI="/home/cfg/_myapps/uhashfs"
EGIT_BRANCH="python3.6+"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc test dev"

DEPEND="
	test? ( dev-python/pytest-cov[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]
			dev-python/tox[${PYTHON_USEDEP}]
			dev-python/twine[${PYTHON_USEDEP}]
			dev-python/wheel[${PYTHON_USEDEP}]
			dev-python/virtualenv[${PYTHON_USEDEP}] )
"

python_install_all() {
	distutils-r1_python_install_all
}
