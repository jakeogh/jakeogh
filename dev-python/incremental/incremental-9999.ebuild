# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{6,7,8} pypy)

inherit distutils-r1
inherit git-r3

DESCRIPTION="Incremental is a small library that versions your Python projects"
HOMEPAGE="https://github.com/hawkowl/incremental https://pypi.org/project/incremental/"
EGIT_REPO_URI="https://github.com/hawkowl/incremental.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

#S=${WORKDIR}/${P}
