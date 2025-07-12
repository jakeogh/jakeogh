# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Python package for writing and reading GGUF (GGML Universal File) format files"
HOMEPAGE="https://github.com/ggml-org/llama.cpp/tree/master/gguf-py"
EGIT_REPO_URI="https://github.com/ggml-org/llama.cpp.git"
EGIT_SUBMODULES=( "*" )
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}"
S="${WORKDIR}/${P}/gguf-py"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="gui"

DEPEND="
	>=dev-python/numpy-1.24[${PYTHON_USEDEP}]
	gui? (
		>=dev-python/PyQt5-5.15[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-python/poetry-core-1.0[${PYTHON_USEDEP}]
	>=dev-python/wheel-0.37[${PYTHON_USEDEP}]
"

src_prepare() {
	# Ensure we're in the gguf-py subdirectory
	if [[ ! -f pyproject.toml ]]; then
		die "pyproject.toml not found in ${S}"
	fi
	default
}

python_install() {
	if use gui; then
		DISTUTILS_ARGS=( --extras=gui )
	else
		DISTUTILS_ARGS=()
	fi
	distutils-r1_python_install
}
