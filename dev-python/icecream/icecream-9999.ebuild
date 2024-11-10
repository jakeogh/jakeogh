# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{10..12})

inherit git-r3
inherit distutils-r1

#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="print() replacement for debugging"
HOMEPAGE="https://github.com/gruns/icecream"
EGIT_REPO_URI="https://github.com/gruns/icecream.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/executing[${PYTHON_USEDEP}]
	dev-python/asttokens[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
