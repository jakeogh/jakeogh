# Copyright 2025
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit git-r3 distutils-r1

DESCRIPTION="Python 3 library for programmatically generating SVG images and animations"
HOMEPAGE="https://github.com/cduck/drawsvg"
EGIT_REPO_URI="https://github.com/cduck/drawsvg.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="raster color"

RDEPEND="
	raster? (
		dev-python/cairosvg[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/imageio[${PYTHON_USEDEP}]
		dev-python/imageio-ffmpeg[${PYTHON_USEDEP}]
	)
	color? (
		dev-python/pwkit[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
	)
"

DEPEND="${RDEPEND}"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"

DOCS=( README.md )

# No tests defined upstream
RESTRICT="test"

