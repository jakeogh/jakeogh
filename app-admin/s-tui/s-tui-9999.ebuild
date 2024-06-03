# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="Stress-Terminal UI monitoring tool"
HOMEPAGE="https://github.com/amanusk/s-tui"
EGIT_REPO_URI="https://github.com/amanusk/s-tui.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/urwid[${PYTHON_USEDEP}]
	app-benchmarks/stress
"

DEPEND="${RDEPEND}"
