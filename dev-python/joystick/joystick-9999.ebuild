# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
inherit git-r3

DESCRIPTION="Real-time plotting and logging while console controlling."
HOMEPAGE="https://github.com/ceyzeriat/joystick/"
EGIT_REPO_URI="https://github.com/ceyzeriat/joystick.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
DEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}

