# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Real-time plotting and logging while console controlling."
HOMEPAGE="https://github.com/ceyzeriat/joystick/"
EGIT_REPO_URI="https://github.com/ceyzeriat/joystick.git"

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

