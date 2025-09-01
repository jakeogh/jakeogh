# /home/sysskel/myapps/jakeogh/dev-python/uharfbuzz/uharfbuzz-9999.ebuild

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

# Must be set before inheriting distutils-r1; upstream uses setuptools.build_meta
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="HarfBuzz Python bindings (Cython), using system harfbuzz"
HOMEPAGE="https://github.com/harfbuzz/uharfbuzz"
EGIT_REPO_URI="https://github.com/harfbuzz/uharfbuzz.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

# Runtime deps
RDEPEND="
	media-libs/harfbuzz
"

# Build-time deps (PEP517 backend + Cython + pkg-config for system harfbuzz)
BDEPEND="
	${RDEPEND}
	virtual/pkgconfig
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

python_compile() {
	# Enforce system harfbuzz instead of vendored copy
	local -x USE_SYSTEM_LIBS=1
	distutils-r1_python_compile
}

python_install() {
	local -x USE_SYSTEM_LIBS=1
	distutils-r1_python_install
}

