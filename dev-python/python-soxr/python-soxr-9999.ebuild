# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1

inherit distutils-r1 git-r3

DESCRIPTION="Python bindings for libsoxr"
HOMEPAGE="https://github.com/dofuuz/python-soxr https://pypi.org/project/soxr/"
EGIT_REPO_URI="https://github.com/dofuuz/python-soxr.git"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS=""

DEPEND="
	media-libs/soxr
"
RDEPEND="
	${DEPEND}
	dev-python/numpy[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_prepare() {
	# Use system libsoxr instead of bundled
	export USE_SYSTEM_LIBSOXR=1
	distutils-r1_src_prepare
}
