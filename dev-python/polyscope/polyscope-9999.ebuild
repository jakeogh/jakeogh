# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13,14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 git-r3

DESCRIPTION="A lightweight, cross-platform C++/Python library for visualizing 3D data"
HOMEPAGE="https://polyscope.run"
EGIT_REPO_URI="https://github.com/nmwsharp/polyscope.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Runtime dependencies
RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pyglm[${PYTHON_USEDEP}]
	dev-python/pyimgui[${PYTHON_USEDEP}]
	dev-python/PyQt5[${PYTHON_USEDEP}]
"

# Build-time: PEP 517 handles everything
# No manual DEPEND needed

RESTRICT="test"  # Upstream tests not suitable for live ebuild

python_prepare_all() {
	# Clean any leftover metadata
	rm -rf src/polyscope.egg-info/ 2>/dev/null || true
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	elog "polyscope successfully installed!"
	elog "Try it: python -c 'import polyscope as ps; ps.init(); ps.register_point_cloud(\"points\", [[0,0,0], [1,1,1]]); ps.show()'"
	elog "Documentation: https://polyscope.run"
}

