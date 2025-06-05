# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="iridb spider launcher"
HOMEPAGE="https://github.com/jakeogh/iridb-spider-wrapper"
EGIT_REPO_URI="https://github.com/jakeogh/iridb-spider-wrapper.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	net-misc/iridb[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
