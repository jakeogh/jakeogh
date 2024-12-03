# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{10..12})

inherit git-r3
inherit distutils-r1

DESCRIPTION="print every n messagepacked items read on stdin to stderr"
HOMEPAGE="https://github.com/jakeogh/mpprogress"
EGIT_REPO_URI="https://github.com/jakeogh/mpprogress.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

#src_prepare() {
#	default
#	xdg_src_prepare
#}