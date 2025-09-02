# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11,12,13} )

# Declare PEP 517 backend before inheriting distutils-r1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="A Python module for scientific analysis and visualization of 3D objects and point clouds"
HOMEPAGE="https://vedo.dev  https://github.com/marcomusy/vedo"
EGIT_REPO_URI="https://github.com/marcomusy/vedo.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Runtime dependencies
RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/trimesh[${PYTHON_USEDEP}]
	dev-python/pyvista[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/imageio[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/panel[${PYTHON_USEDEP}]
	dev-python/param[${PYTHON_USEDEP}]
"

# Build-time dependencies
BDEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"

# No test phase by default
RESTRICT="test"

python_prepare_all() {
	# Ensure no leftover metadata
	rm -rf src/vedo.egg-info/ 2>/dev/null || true
	distutils-r1_python_prepare_all
}

src_test() {
	# Optional: run tests if desired
	# ewarn "Tests not enabled; enable manually if desired"
	python setup.py test
}

pkg_postinst() {
	elog "vedo successfully installed!"
	elog "Try it: python -c 'from vedo import Cube; Cube().show()'"
	elog "Documentation: https://vedo.dev"
}


