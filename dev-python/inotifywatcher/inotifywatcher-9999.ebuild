# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3

DESCRIPTION="Report inotify events for a path."
HOMEPAGE="https://github.com/jakeogh/inotifywatcher"
EGIT_REPO_URI="https://github.com/jakeogh/inotifywatcher.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/click
	dev-python/pyinotify
"

RDEPEND="
	${DEPEND}
"

python_install_all() {
#	local DOCS=( README.md )
#	mkdir /var/tmp/iridb
#	chmod o+w /var/tmp/iridb
	distutils-r1_python_install_all
}
