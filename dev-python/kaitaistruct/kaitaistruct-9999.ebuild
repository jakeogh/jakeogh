# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} pypy )

inherit distutils-r1

DESCRIPTION="Kaitai Struct runtime for Python"
HOMEPAGE="https://kaitai.io/"
EGIT_REPO_URI="https://github.com/kaitai-io/kaitai_struct"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
