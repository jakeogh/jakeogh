# SPDX-License-Identifier: CDDL-1.0

EAPI=8
PYTHON_COMPAT=( python3_{12,13} )
DISTUTILS_USE_PEP517=flit

inherit distutils-r1

DESCRIPTION="msgpack-typed domain objects with tty-aware output"
HOMEPAGE=""
SRC_URI=""

S="${WORKDIR}"

LICENSE="CDDL-1.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/msgpack[${PYTHON_USEDEP}]
"
BDEPEND="
	${PYTHON_DEPS}
	dev-python/flit-core[${PYTHON_USEDEP}]
"

src_unpack() {
	mkdir -p "${S}"
	cp "${FILESDIR}/mptyped.py" "${S}/"
	cp "${FILESDIR}/pyproject.toml" "${S}/"
}
