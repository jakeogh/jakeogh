# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Tag and save iris"
HOMEPAGE="https://github.com/jakeogh/iridb"
EGIT_REPO_URI="/home/cfg/_myapps/iridb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/cssselect
	dev-python/yapsy
	dev-python/sh
	dev-python/werkzeug
	dev-python/lxml
	dev-python/colorama
	dev-python/argh
	dev-python/sqlalchemy
	dev-python/requests
	dev-python/tldextract
	dev-python/amara3-iri
	dev-python/numpy
	dev-python/pydot
	dev-db/postgresql:*
	dev-python/httplib2
	dev-python/python-dmenu
	dev-python/beautifulsoup:*
	dev-python/requests-cache
	dev-python/requests-file
	dev-python/sqlalchemy-utils
	dev-db/redis
	dev-python/anormbookmarker
"
#	dev-python/ghost

RDEPEND="
	${DEPEND}
	x11-misc/dmenu
"

python_install_all() {
	local DOCS=( README.md )
	distutils-r1_python_install_all
}
