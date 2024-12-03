# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="read NULL terminated byte groups from stdin and write messagepacked byte groups to stdout"
HOMEPAGE="https://github.com/jakeogh/null2mp"
EGIT_REPO_URI="https://github.com/jakeogh/null2mp.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/bytestool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

