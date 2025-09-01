# Copyright 2025
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

# PEP 517 backend
DISTUTILS_USE_PEP517="flit"

inherit git-r3 distutils-r1

DESCRIPTION="Powerful and versatile visualization for Python (built on WebGPU via wgpu-py)"
HOMEPAGE="https://pygfx.org https://docs.pygfx.org https://github.com/pygfx/pygfx"
EGIT_REPO_URI="https://github.com/pygfx/pygfx.git"
EGIT_BRANCH="main"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
PROPERTIES="live"

IUSE=""

# Core runtime deps; window backends are optional (see postinst note)
RDEPEND="
	dev-python/wgpu[${PYTHON_USEDEP}]
	dev-python/pylinalg[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

# Upstream tests need a working GPU/driver & specific env; skip by default.
RESTRICT="test"

DOCS=( README.md )

pkg_postinst() {
	elog "pygfx renders to a windowing backend provided by wgpu-py."
	elog "Install one as needed, e.g.: dev-python/glfw, dev-python/PyQt6,"
	elog "dev-python/PySide6, dev-python/wxpython, or dev-python/jupyter_rfb."
}

