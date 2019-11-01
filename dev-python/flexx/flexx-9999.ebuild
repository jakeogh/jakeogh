# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1 git-r3

DESCRIPTION="Pure Python toolkit for creating GUI's using web technology"
HOMEPAGE="https://github.com/flexxui/flexx"
SRC_URI="https://github.com/flexxui/flexx.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

#IUSE="doc test" broken tests
IUSE=""
RDEPEND="www-servers/tornado[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
