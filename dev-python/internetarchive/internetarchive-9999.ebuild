# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=(python3_{10..12})

inherit git-r3
inherit distutils-r1

#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="Python and Command-Line Interface to Archive.org"
HOMEPAGE="https://github.com/jakeogh/internetarchive"
EGIT_REPO_URI="/home/sysskel/myapps/internetarchive https://github.com/jakeogh/internetarchive.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/jsonpatch[${PYTHON_USEDEP}]
	dev-python/schema[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
