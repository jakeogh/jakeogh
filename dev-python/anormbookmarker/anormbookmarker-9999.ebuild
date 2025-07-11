# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3

DESCRIPTION="Tag SQLAlchemy mapper classes."
HOMEPAGE="https://github.com/jakeogh/anormbookmarker"
EGIT_REPO_URI="https://github.com/jakeogh/anormbookmarker.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/sqlalchemy
	dev-db/postgresql:*
"

RDEPEND="
	${DEPEND}
	x11-misc/dmenu
"

python_install_all() {
	local DOCS=( README.md )
	distutils-r1_python_install_all
}
