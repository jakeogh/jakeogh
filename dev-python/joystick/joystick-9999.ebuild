# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Real-time plotting and logging while console controlling."
HOMEPAGE="https://github.com/ceyzeriat/joystick/"
EGIT_REPO_URI="https://github.com/ceyzeriat/joystick/.git"
#EGIT_BRANCH="dev"
#EGIT_SUBMODULES=("tests")
#EGIT_SUBMODULES=()

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="doc"
#RESTRICT="test"
DEPEND="
	dev-python/numpy
	dev-python/matplotlib
"

RDEPEND="${DEPEND}"


python_install_all() {
	distutils-r1_python_install_all
}

