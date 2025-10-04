# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1
inherit git-r3


DESCRIPTION="Python package for producing high-quality electrical circuit schematic diagrams"
HOMEPAGE="https://schemdraw.readthedocs.io/ https://github.com/cdelker/schemdraw"
EGIT_REPO_URI="https://github.com/cdelker/schemdraw.git"

LICENSE="MIT"
SLOT="0"
IUSE="matplotlib svgmath test doc"
RESTRICT="!test? ( test )"

RDEPEND="
	matplotlib? (
		>=dev-python/matplotlib-3.3[${PYTHON_USEDEP}]
	)
	svgmath? (
		dev-python/ziamath[${PYTHON_USEDEP}]
	)
"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-3.3[${PYTHON_USEDEP}]
		dev-python/nbval[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local -x MPLBACKEND=Agg
	epytest
}

python_install_all() {
	distutils-r1_python_install_all

	dodoc README.md
	if use doc; then
		dodoc -r docs/
	fi
}

pkg_postinst() {
	elog "Schemdraw is a Python package for producing high-quality"
	elog "electrical circuit schematic diagrams."
	elog ""
	elog "Optional dependencies:"
	elog "  matplotlib - For Matplotlib rendering backend (recommended)"
	elog "  svgmath    - For math expressions in SVG backend"
	elog ""
	elog "Documentation: https://schemdraw.readthedocs.io/"
}

