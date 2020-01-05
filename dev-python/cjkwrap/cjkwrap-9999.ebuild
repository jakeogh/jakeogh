# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="A library for wrapping and filling UTF-8 CJK text"
HOMEPAGE="https://f.gallai.re/cjkwrap"
EGIT_REPO_URI="https://github.com/fgallaire/cjkwrap.git"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
