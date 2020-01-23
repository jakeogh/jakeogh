# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Jupyter Notebook Tools for Sphinx"
HOMEPAGE="https://github.com/spatialaudio/nbsphinx/"
EGIT_REPO_URI="https://github.com/spatialaudio/nbsphinx.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/nbconvert[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
	>=dev-python/sphinx-1.3.2[${PYTHON_USEDEP}]
	dev-python/traitlets[${PYTHON_USEDEP}]
	"
DEPEND="${RDEPEND}"
