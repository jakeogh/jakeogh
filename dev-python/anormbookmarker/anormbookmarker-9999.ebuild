# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
#PYTHON_COMPAT=( pypy )
PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Tag SQLAlchemy mapper classes."
HOMEPAGE="https://github.com/jakeogh/anormbookmarker"
EGIT_REPO_URI="/home/cfg/_myapps/anormbookmarker https://github.com/jakeogh/anormbookmarker.git"

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
