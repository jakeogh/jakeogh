# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Specifications for callback functions passed in to an API"
HOMEPAGE="https://pypi.org/project/backcall/"
EGIT_REPO_URI="https://github.com/takluyver/backcall.git"
EGIT_COMMIT="8eb45a77a40edad74b33086d05fd4d99d43d80b0"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]"
#	dev-python/pyproject2setuppy[${PYTHON_USEDEP}]"

#src_prepare() {
#	python -m pyproject2setuppy.main build
#	eapply_user
#}
