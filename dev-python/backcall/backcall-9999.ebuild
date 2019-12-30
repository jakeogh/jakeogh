# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{6,7,8} )

#inherit distutils-r1
inherit git-r3

DESCRIPTION="Specifications for callback functions passed in to an API"
HOMEPAGE="https://pypi.org/project/backcall/"
EGIT_REPO_URI="https://github.com/takluyver/backcall.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="
	dev-python/flit[${PYTHON_USEDEP}]"

#	dev-python/setuptools[${PYTHON_USEDEP}]
