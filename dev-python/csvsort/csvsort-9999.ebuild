# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1

DESCRIPTION="example of a local-only package"
HOMEPAGE="https://github.com/jakeogh/csvsort"
EGIT_REPO_URI="https://github.com/jakeogh/csvsort.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
