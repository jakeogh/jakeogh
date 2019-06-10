# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{3_6,3_7} )

inherit distutils-r1 git-r3

DESCRIPTION="A content-addressable file management system for Python"
HOMEPAGE="https://github.com/jakeogh/uhashfs"
EGIT_REPO_URI="/home/cfg/_myapps/uhashfs https://github.com/jakeogh/uhashfs.git"
#EGIT_BRANCH="python3.6+"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc test dev"

DEPEND="
	dev-python/humanize,
	test? ( dev-python/pytest-cov
			dev-python/pytest
			dev-python/tox
			dev-python/twine
			dev-python/wheel
			dev-python/virtualenv )
"

python_install_all() {
	distutils-r1_python_install_all
}
