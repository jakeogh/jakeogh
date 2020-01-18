# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{7,8} )

inherit distutils-r1 git-r3

DESCRIPTION="An easy (and up to date) way to access Twitter data with Python"
HOMEPAGE="https://github.com/ryanmcgrath/twython"
#SRC_URI="mirror://pypi/t/${PN}/${P}.tar.gz"
EGIT_REPO_URI="https://github.com/ryanmcgrath/twython.git"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/requests-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/requests-oauthlib-0.4.0[${PYTHON_USEDEP}]"
