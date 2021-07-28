# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/asciimatics"
EGIT_REPO_URI="/home/cfg/_myapps/asciimatics https://github.com/jakeogh/asciimatics.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/pyfiglet[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
