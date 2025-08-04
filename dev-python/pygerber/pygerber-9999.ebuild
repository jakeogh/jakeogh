# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 git-r3

DESCRIPTION="Parser, renderer, and viewer for Gerber files"
HOMEPAGE="https://github.com/Argmaster/pygerber"
EGIT_REPO_URI="https://github.com/Argmaster/pygerber.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test deploy doc image-analysis language-server pygments shapely style svg"

RESTRICT="!test? ( test )"

BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/svglib[${PYTHON_USEDEP}]
		dev-python/reportlab[${PYTHON_USEDEP}]
	)
"

RDEPEND="
	dev-python/shapely[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/drawsvg[${PYTHON_USEDEP}]
	dev-python/svglib[${PYTHON_USEDEP}]
	dev-python/reportlab[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_prepare_all() {
	# Install with all extras enabled (e.g., svg)
	export POETRY_INSTALL_OPTS="--all-extras"
	distutils-r1_python_prepare_all
}
