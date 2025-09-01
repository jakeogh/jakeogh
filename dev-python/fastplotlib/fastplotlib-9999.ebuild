# Copyright 2025
# Distributed under the terms of the Apache License 2.0

EAPI=8

PYTHON_COMPAT=( python3_10 python3_11 python3_12 python3_13 )

DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 git-r3

DESCRIPTION="GPU-accelerated plotting on WGPU via pygfx (live ebuild)"
HOMEPAGE="https://fastplotlib.org https://github.com/fastplotlib/fastplotlib"
EGIT_REPO_URI="https://github.com/fastplotlib/fastplotlib.git"
# EGIT_BRANCH defaults to the repo default (main)

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="+qt pyside glfw wxpython imgui notebook examples test"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/numpy-1.20[${PYTHON_USEDEP}]
	>=dev-python/pygfx-0.5[${PYTHON_USEDEP}]
	>=dev-python/wgpu-0.16[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	qt? ( dev-python/pyqt6[gui,widgets,${PYTHON_USEDEP}] )
	pyside? ( dev-python/pyside6[gui,widgets,${PYTHON_USEDEP}] )
	glfw? ( dev-python/glfw[${PYTHON_USEDEP}] )
	wxpython? ( dev-python/wxpython[${PYTHON_USEDEP}] )
	imgui? ( dev-python/imgui-bundle[${PYTHON_USEDEP}] )
	notebook? (
		dev-python/jupyterlab[${PYTHON_USEDEP}]
		dev-python/jupyter-rfb[${PYTHON_USEDEP}]
		dev-python/ipywidgets[${PYTHON_USEDEP}]
		media-libs/libjpeg-turbo
		dev-python/simplejpeg[${PYTHON_USEDEP}]
	)
"

BDEPEND="
	${PYTHON_DEPS}
	dev-python/hatchling[${PYTHON_USEDEP}]
"

RESTRICT="!test? ( test )"

src_prepare() {
	default
}

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all

	if use examples ; then
		insinto /usr/share/${PN}/examples
		doins -r examples/* || die
	fi
}

pkg_postinst() {
	elog "fastplotlib runs on pygfx/wgpu; ensure a modern GPU/driver stack."
	elog "Optional backends via USE: qt, pyside, glfw, wxpython."
	elog "Extras via USE: imgui, notebook."
}

