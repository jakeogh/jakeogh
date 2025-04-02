# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

REALNAME="${PN}"
LITERALNAME="${PN}"
REALVERSION="${PV}"
DIGEST_SOURCES="yes"
PYTHON_COMPAT=(python{3_10,3_11,3_12})
DISTUTILS_USE_PEP517=standalone

inherit python-r1 git-r3

DESCRIPTION="Navigate Edgar filings with ease"

HOMEPAGE=""
LICENSE="MIT"
#SRC_URI="https://files.pythonhosted.org/packages/source/${REALNAME::1}/${REALNAME}/${REALNAME}-${REALVERSION}.tar.gz"
EGIT_REPO_URI="https://github.com/dgunning/edgartools"
#SOURCEFILE="${REALNAME}-${REALVERSION}.tar.gz"
RESTRICT="test"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
DEPENDENCIES=">=dev-python/beautifulsoup4-4.10.0[${PYTHON_USEDEP}]
	dev-python/fastcore[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.25.0[${PYTHON_USEDEP}]
	>=dev-python/humanize-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.4[${PYTHON_USEDEP}]
	>=dev-python/nest-asyncio-1.5.1[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.6.0[${PYTHON_USEDEP}]
	>=dev-python/pandas-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyarrow-14.0.0:gentoo[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.0.0[${PYTHON_USEDEP}]
	dev-python/rank-bm25[${PYTHON_USEDEP}]
	>=dev-python/rapidfuzz-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/rich-13.0.0[${PYTHON_USEDEP}]
	dev-python/stamina[${PYTHON_USEDEP}]
	>=dev-python/tabulate-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/textdistance-4.5.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.62.0[${PYTHON_USEDEP}]
	>=dev-python/unidecode-1.2.0[${PYTHON_USEDEP}]"
BDEPEND="${DEPENDENCIES}"
RDEPEND="${DEPENDENCIES}"
