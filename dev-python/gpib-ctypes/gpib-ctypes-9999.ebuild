# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="Cross-platform Python bindings for the NI GPIB and linux-gpib C interfaces."
HOMEPAGE="https://github.com/dirkenstein/gpib_ctypes"
EGIT_REPO_URI="https://github.com/dirkenstein/gpib_ctypes.git"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS=""

RDEPEND=""

DEPEND="${RDEPEND}"

distutils_enable_tests pytest
# exception: No module named 'sphinx.apidoc' even if sphinxcontrib-apidoc is installed
#distutils_enable_sphinx docs dev-python/sphinxcontrib-apidoc

python_prepare_all() {
        # do not depend on pytest-runner
        sed -i -e '/pytest-runner/d' setup.py || die

        distutils-r1_python_prepare_all
}


