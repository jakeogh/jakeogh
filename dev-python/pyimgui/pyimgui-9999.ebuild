# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13,14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 git-r3

DESCRIPTION="Python wrapper for ImGui (immediate mode GUI library)"
HOMEPAGE="https://github.com/pyimgui/pyimgui"
EGIT_REPO_URI="https://github.com/pyimgui/pyimgui.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Runtime dependencies
RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
"

# No manual DEPEND — handled by PEP 517
# Build deps (setuptools, wheel) are automatic

python_prepare_all() {
	# Clean any leftover metadata
	rm -rf src/imgui.egg-info/ 2>/dev/null || true
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	elog "pyimgui successfully installed!"
	elog "Try it: python -c 'import imgui; print(imgui.__version__)'"
	elog "Documentation: https://pyimgui.readthedocs.io"
}

