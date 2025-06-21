# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Various BM25 algorithms for document ranking"
HOMEPAGE="https://github.com/dorianbrown/rank_bm25"
EGIT_REPO_URI="https://github.com/dorianbrown/rank_bm25.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="test"

IUSE="dev"
DEPENDENCIES="dev-python/numpy[${PYTHON_USEDEP}]
        dev? ( dev-python/pytest[${PYTHON_USEDEP}] )"
BDEPEND="${DEPENDENCIES}"
RDEPEND="${DEPENDENCIES}"
