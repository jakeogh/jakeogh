# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13,14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 git-r3

DESCRIPTION="A high-level app and dashboarding solution for Python"
HOMEPAGE="https://panel.holoviz.org"
EGIT_REPO_URI="https://github.com/holoviz/panel.git"
EGIT_BRANCH="main"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples server"

# Runtime dependencies
RDEPEND="
	dev-python/param[${PYTHON_USEDEP}]
	dev-python/paramnb[${PYTHON_USEDEP}]
	dev-python/parambokeh[${PYTHON_USEDEP}]
	dev-python/bokeh[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/tornado[${PYTHON_USEDEP}]
	dev-python/pyct[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/markupsafe[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	dev-python/bleach[${PYTHON_USEDEP}]
	dev-python/watchdog[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	server? (
		dev-python/uvicorn[${PYTHON_USEDEP}]
		dev-python/websockets[${PYTHON_USEDEP}]
	)
"

# Optional: docs and examples
DEPEND="
	${RDEPEND}
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
		dev-python/nbsphinx[${PYTHON_USEDEP}]
		dev-python/jupyter-sphinx[${PYTHON_USEDEP}]
		dev-python/ipython[${PYTHON_USEDEP}]
	)
	examples? (
		dev-python/ipywidgets[${PYTHON_USEDEP}]
		dev-python/ipykernel[${PYTHON_USEDEP}]
		dev-python/notebook[${PYTHON_USEDEP}]
	)
"

RESTRICT="test"  # Upstream tests require network and are not suitable for live ebuild

python_prepare_all() {
	# Clean any leftover metadata
	rm -rf src/panel.egg-info/ 2>/dev/null || true
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	elog "panel successfully installed!"
	elog "Try it: python -c 'import panel as pn; pn.extension(); pn.pane.Markdown(\"# Hello Panel\").servable()'"
	elog "Documentation: https://panel.holoviz.org"
	if use doc; then
		elog "Documentation built (doc USE flag enabled)"
	fi
	if use examples; then
		elog "Example dependencies installed"
	fi
}

