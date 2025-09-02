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

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
"

src_prepare() {
	# Patch 1: Fix SizeofTypeNode crash
	sed -i 's/sizeof(ImDrawIdx)/2 if sizeof(ImDrawIdx) == 2 else 4/g' \
		"${S}/imgui/core.pyx" || die "Failed to patch sizeof"

	# Patch 2: Ensure cimgui types are declared
	if ! grep -q "cdef extern from" "${S}/imgui/core.pyx"; then
		elog "Warning: cimgui extern declarations missing, consider updating cimgui"
	fi

	# Clean metadata
	rm -rf src/imgui.egg-info/ 2>/dev/null || true
	distutils-r1_src_prepare
}

python_prepare_all() {
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	elog "pyimgui successfully installed!"
	elog "Try it: python -c 'import imgui; print(imgui.__version__)'"
	elog "Documentation: https://pyimgui.readthedocs.io"
}


