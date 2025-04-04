EAPI=8

REALNAME="${PN}"
LITERALNAME="${PN}"
REALVERSION="${PV}"
DIGEST_SOURCES="yes"
PYTHON_COMPAT=(python{3_10,3_11,3_12})
DISTUTILS_USE_PEP517=poetry

inherit python-r1

DESCRIPTION="Python Rate-Limiter using Leaky-Bucket Algorithm"

HOMEPAGE="https://github.com/vutran1710/PyrateLimiter"
LICENSE="MIT"
SRC_URI="https://github.com/vutran1710/PyrateLimiter/archive/refs/tags/v2.8.0.tar.gz"
RESTRICT="test"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="all docs"
DEPENDENCIES="all? ( >=dev-python/filelock-3.0[${PYTHON_USEDEP}] )
	all? ( <dev-python/redis-6.0.0[${PYTHON_USEDEP}] )
	all? ( <dev-python/psycopg-4.0.0[${PYTHON_USEDEP}] )
	docs? ( <dev-python/furo-2023.0.0[${PYTHON_USEDEP}] )
	docs? ( >=dev-python/myst-parser-0.17[${PYTHON_USEDEP}] )
	docs? ( <dev-python/sphinx-5.0.0[${PYTHON_USEDEP}] )
	docs? ( <dev-python/sphinx-autodoc-typehints-2.0[${PYTHON_USEDEP}] )
	docs? ( >=dev-python/sphinx-copybutton-0.5[${PYTHON_USEDEP}] )
	docs? ( <dev-python/sphinxcontrib-apidoc-0.4[${PYTHON_USEDEP}] )"
BDEPEND="${DEPENDENCIES}"
RDEPEND="${DEPENDENCIES}"

echo "${WORKDIR}"
