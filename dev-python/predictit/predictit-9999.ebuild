# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="graph predictit"
HOMEPAGE="https://github.com/jakeogh/predictit"
EGIT_REPO_URI="/home/cfg/_myapps/predictit"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/matplotlib
	dev-python/requests
	dev-db/postgresql
	dev-python/httplib2
"

RDEPEND="
	${DEPEND}
	dev-python/pyside:2
	x11-misc/dmenu
"

python_install_all() {
	local DOCS=( README.md )
	distutils-r1_python_install_all
}
