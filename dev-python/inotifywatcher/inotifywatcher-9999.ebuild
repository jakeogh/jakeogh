# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Report inotify events for a path."
HOMEPAGE="https://github.com/jakeogh/inotifypublisher"
EGIT_REPO_URI="/home/cfg/_myapps/inotifypublisher"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
