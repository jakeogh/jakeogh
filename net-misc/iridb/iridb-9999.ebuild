# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Tag and save iris"
HOMEPAGE="https://github.com/jakeogh/iridb"
EGIT_REPO_URI="/home/cfg/_myapps/iridb"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/uhashfs[${PYTHON_USEDEP}]
	dev-python/cssselect[${PYTHON_USEDEP}]
	dev-python/yapsy[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tldextract[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/python-dmenu[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:*[${PYTHON_USEDEP}]
	dev-python/requests-cache[${PYTHON_USEDEP}]
	dev-python/requests-file[${PYTHON_USEDEP}]
	dev-python/requests-ftp[${PYTHON_USEDEP}]
	dev-python/classify[${PYTHON_USEDEP}]
	app-text/tree
	dev-python/pudb[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/tld[${PYTHON_USEDEP}]
	app-text/slmenu
"

#	sys-apps/file[python]
#	dev-python/pydot[${PYTHON_USEDEP}]
#	dev-db/sadisplay[${PYTHON_USEDEP}]
#	dev-python/redis-py[${PYTHON_USEDEP}]
#	dev-python/anormbookmarker[${PYTHON_USEDEP}]
#	dev-python/psycopg[${PYTHON_USEDEP}]
#	dev-python/sqlalchemy-utils[${PYTHON_USEDEP}]
#	dev-db/postgresql:*
#	dev-python/amara3-iri[${PYTHON_USEDEP}]

RDEPEND="
	${DEPEND}
	x11-misc/dmenu
"

python_install_all() {
	local DOCS=( README.md )
	mkdir /var/tmp/iridb
	chmod o+w /var/tmp/iridb
	distutils-r1_python_install_all
}
