# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Tool to Detect Surrounding Shell"
HOMEPAGE="
	https://github.com/sarugaku/shellingham
"
SRC_URI="
	https://github.com/sarugaku/shellingham/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
