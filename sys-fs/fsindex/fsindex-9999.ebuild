# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="DB backed filesystem hash index."
HOMEPAGE="https://github.com/jakeogh/fsindex"
EGIT_REPO_URI="/home/cfg/_myapps/fsindex https://github.com/jakeogh/fsindex.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/kcl
	dev-python/sqlalchemy
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
