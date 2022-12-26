# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1

#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="3D medical imaging reconstruction software"
HOMEPAGE="https://github.com/jakeogh/invesalius3"
EGIT_REPO_URI="/home/cfg/_myapps/invesalius3 https://github.com/jakeogh/invesalius3.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}

#src_prepare() {
#	default
#	xdg_src_prepare
#}
