# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Match sci-libs/vtk: single Python target
PYTHON_COMPAT=( python3_13 )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 git-r3

DESCRIPTION="A Python module for scientific analysis and visualization of 3D objects and point clouds"
HOMEPAGE="https://vedo.dev"
EGIT_REPO_URI="https://github.com/marcomusy/vedo.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# DO NOT use ${PYTHON_USEDEP} or ${PYTHON_SINGLE_USEDEP}
# Let distutils-r1 handle Python deps via PYTHON_COMPAT
RDEPEND="
	sci-libs/vtk[python,imaging,rendering,views]
	dev-python/numpy
	dev-python/requests
	dev-python/trimesh
	dev-python/pyvista
	dev-python/tqdm
	dev-python/imageio
	dev-python/pillow
	dev-python/panel
	dev-python/param
"

# DEPEND is omitted — handled by distutils-r1 + DISTUTILS_USE_PEP517

RESTRICT="test"

python_prepare_all() {
	# Clean any leftover metadata
	rm -rf src/vedo.egg-info/ 2>/dev/null || true
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	elog "vedo successfully installed!"
	elog "Try it: python -c 'from vedo import Cube; Cube().show()'"
	elog "Documentation: https://vedo.dev"
}
