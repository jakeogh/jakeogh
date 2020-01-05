# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} pypy{,3} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="ReadTheDocs.org theme for Sphinx"
HOMEPAGE="https://github.com/snide/sphinx_rtd_theme/"
EGIT_REPO_URI="https://github.com/snide/sphinx_rtd_theme.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
