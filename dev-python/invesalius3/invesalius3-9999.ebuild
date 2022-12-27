# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="3D medical imaging reconstruction software"
HOMEPAGE="https://github.com/jakeogh/invesalius3"
EGIT_REPO_URI="/home/cfg/_myapps/invesalius3 https://github.com/jakeogh/invesalius3.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""


RDEPEND="
	sci-libs/gdcm[${PYTHON_USEDEP}]
	dev-python/imageio[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

# no change
#python_configure_all() {
#	cat >> setup.cfg <<-EOF
#	[build_ext]
#	EOF
#}

python_install_all() {
	distutils-r1_python_install_all
}

#src_prepare() {
#	default
#	xdg_src_prepare
#}
