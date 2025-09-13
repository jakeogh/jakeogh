# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3 distutils-r1

DESCRIPTION="NumPy-aware dynamic Python compiler using LLVM"
HOMEPAGE="https://numba.pydata.org/ https://github.com/numba/numba"
EGIT_REPO_URI="https://github.com/numba/numba.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="test"

# Enable pytest if USE=test
distutils_enable_tests pytest

RDEPEND="
	>=dev-python/numpy-1.24[${PYTHON_USEDEP}]
	>=dev-python/llvmlite-0.42[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

BDEPEND="
	${PYTHON_DEPS}
	test? (
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	)
"

src_prepare() {
	default

	# Fix the versioneer.py SyntaxWarning about invalid escape sequence
	if [[ -f versioneer.py ]]; then
		sed -i 's/r'\''=\\s\*"(.*)"'\''/r'\''=\\\\s*"(.*)"'\''/g' versioneer.py || die "Failed to fix versioneer.py regex"
	fi
}

python_test() {
	# Run basic numba tests - note that full test suite is very extensive
	"${EPYTHON}" -m pytest numba/tests/test_basic.py -v || die "Tests failed with ${EPYTHON}"
}
