# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="wrapper for youtube-dl"
HOMEPAGE="https://github.com/jakeogh/youtube-dl-wrapper"
EGIT_REPO_URI="/home/user/_myapps/youtube-dl-wrapper https://github.com/jakeogh/youtube-dl-wrapper.git"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/sh
	net-misc/youtube-dl
"

RDEPEND="${DEPEND}"

python_install_all() {
        distutils-r1_python_install_all
}

#        local DOCS=( README.md )
