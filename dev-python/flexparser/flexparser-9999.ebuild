# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3


#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="unknown"
HOMEPAGE="https://github.com/hgrecco/flexparser"
EGIT_REPO_URI="/home/sysskel/myapps/flexparser https://github.com/hgrecco/flexparser.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

