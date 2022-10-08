# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="graph predictit"
HOMEPAGE="https://github.com/jakeogh/predictit"
EGIT_REPO_URI="/home/cfg/_myapps/predictit"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-db/postgresql:*
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/dateparser[${PYTHON_USEDEP}]
	dev-python/pygobject:*[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	net-misc/iridb
	dev-python/twitter[${PYTHON_USEDEP}]
	app-misc/beep
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/ghost[${PYTHON_USEDEP}]
"

RDEPEND="
	${DEPEND}
	x11-misc/dmenu
"

python_install_all() {
	local DOCS=( README.md )
	distutils-r1_python_install_all
}
