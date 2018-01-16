# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="An FTP transport adapter for use with the Python Requests library."
HOMEPAGE="https://github.com/Lukasa/requests-ftp"
EGIT_REPO_URI="https://github.com/Lukasa/requests-ftp.git"
#EGIT_BRANCH="dev"
#EGIT_SUBMODULES=("tests")
EGIT_SUBMODULES=()

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
#RESTRICT="test"
#DEPEND="
#	dev-python/pyside:0
#	dev-python/xvfbwrapper
#"

#RDEPEND="${DEPEND}"

#python_prepare_all() {
#	rm -r ${WORKDIR}/ghost-9999/tests/
#	distutils-r1_python_prepare_all
#}

#python_install_all() {
#	distutils-r1_python_install_all
#}

#        local DOCS=( README.md )
