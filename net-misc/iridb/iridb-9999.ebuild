# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Tag and save iris"
HOMEPAGE="https://github.com/jakeogh/iridb"
EGIT_REPO_URI="/home/cfg/_myapps/iridb"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-plugins[${PYTHON_USEDEP}]
	dev-python/click-option-group[${PYTHON_USEDEP}]
	dev-python/uhashfs[${PYTHON_USEDEP}]
	app-misc/uhashfsc
	dev-python/retry_on_exception[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/htmlparser[${PYTHON_USEDEP}]
	dev-python/reify[${PYTHON_USEDEP}]
	dev-python/rediskey[${PYTHON_USEDEP}]
	dev-python/enumerate_input[${PYTHON_USEDEP}]
	dev-python/statfilter[${PYTHON_USEDEP}]
	dev-python/youtube-dl-wrapper[${PYTHON_USEDEP}]
	dev-python/iterator_filter[${PYTHON_USEDEP}]
	dev-python/uniquepipe[${PYTHON_USEDEP}]
	dev-python/cssselect[${PYTHON_USEDEP}]
	dev-python/yapsy[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
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
	dev-python/ordered-set[${PYTHON_USEDEP}]
	app-text/tree
	dev-python/pudb[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/tld[${PYTHON_USEDEP}]
	dev-python/npyscreen[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]
	dev-python/menu[${PYTHON_USEDEP}]
	dev-python/pdfx[${PYTHON_USEDEP}]
"

#	dev-python/lazy_import[${PYTHON_USEDEP}]
#	dev-python/sqlalchemy[${PYTHON_USEDEP}]
#	dev-python/youtube-dl-wrapper[${PYTHON_USEDEP}]
#	sys-apps/file[python]
#	dev-python/pydot[${PYTHON_USEDEP}]
#	dev-db/sadisplay[${PYTHON_USEDEP}]
#	dev-python/redis-py[${PYTHON_USEDEP}]
#	dev-python/anormbookmarker[${PYTHON_USEDEP}]
#	dev-python/psycopg[${PYTHON_USEDEP}]
#	dev-python/sqlalchemy-utils[${PYTHON_USEDEP}]
#	dev-db/postgresql:*
#	dev-python/amara3-iri[${PYTHON_USEDEP}]

#RDEPEND="
#	${DEPEND}
#"

python_install_all() {
	local DOCS=( README.md )
	mkdir /var/tmp/iridb
	chmod o+w /var/tmp/iridb
	distutils-r1_python_install_all
}
