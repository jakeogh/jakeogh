# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="print() alias that writes to sys.stderr prepended by stack metadata"
HOMEPAGE="https://github.com/jakeogh/epprint"
EGIT_REPO_URI="/home/cfg/_myapps/epprint https://github.com/jakeogh/epprint.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/eprint[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
