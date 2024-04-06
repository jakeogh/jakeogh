# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="3D medical imaging reconstruction software"
HOMEPAGE="https://github.com/jakeogh/invesalius3"
EGIT_REPO_URI="/home/sysskel/myapps/invesalius3 https://github.com/jakeogh/invesalius3.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""


#	sci-libs/gdcm[${PYTHON_USEDEP}]
#	dev-python/pyvista[${PYTHON_USEDEP}]
RDEPEND="
	dev-python/imageio[${PYTHON_USEDEP}]
	sci-libs/scikit-image[${PYTHON_USEDEP}]
	sci-libs/nibabel[${PYTHON_USEDEP}]
	dev-python/pyacvd[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}

