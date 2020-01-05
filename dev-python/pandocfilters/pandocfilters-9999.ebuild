# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Utilities for writing pandoc filters in python"
HOMEPAGE="https://github.com/jgm/pandocfilters"
EGIT_REPO_URI="https://github.com/jgm/pandocfilters.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""
