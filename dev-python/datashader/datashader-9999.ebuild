# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Quickly and accurately render even the largest data"
HOMEPAGE="https://github.com/holoviz/datashader"
EGIT_REPO_URI="https://github.com/holoviz/datashader.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
