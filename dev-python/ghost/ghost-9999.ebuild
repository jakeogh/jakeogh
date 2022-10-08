# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Webkit based scriptable web browser for python."
HOMEPAGE="https://github.com/jeanphix/Ghost.py"
#EGIT_REPO_URI="https://github.com/jeanphix/Ghost.py.git"
#EGIT_REPO_URI="https://github.com/jakeogh/Ghost.py.git"
EGIT_REPO_URI="https://github.com/EvaSDK/Ghost.py"
#EGIT_BRANCH="dev"
#EGIT_SUBMODULES=("tests")
EGIT_SUBMODULES=()

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc"
#RESTRICT="test"

DEPEND="
	dev-python/PyQt5[gui,widgets,printsupport,${PYTHON_USEDEP}]
	dev-python/xvfbwrapper
"
#	dev-python/PyQt5[gui,network,webkit,widgets,printsupport,${PYTHON_USEDEP}]

RDEPEND="${DEPEND}"

python_prepare_all() {
	rm -r "${WORKDIR}/ghost-9999/tests/"
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}
