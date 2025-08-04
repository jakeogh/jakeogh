# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} pypy3 )
inherit distutils-r1
inherit git-r3

DESCRIPTION="Parsing, formatting, and rendering toolkit for Gerber X3/X2 file format"
HOMEPAGE="https://github.com/Argmaster/pygerber"
EGIT_REPO_URI="https://github.com/Argmaster/pygerber"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="language-server svg pygments shapely image-analysis doc style deploy"

# Required dependencies from pyproject.toml
RDEPEND="
	>=dev-python/click-8.0.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.12[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/pyparsing-3.0.0[${PYTHON_USEDEP}]
		<dev-python/pyparsing-3.2.0[${PYTHON_USEDEP}]
	' python3_8)
	$(python_gen_cond_dep '
		>=dev-python/pyparsing-3.0.0[${PYTHON_USEDEP}]
	' python3_{9..13} pypy3)
	$(python_gen_cond_dep '
		>=dev-python/pillow-8.0.0[${PYTHON_USEDEP}]
		<dev-python/pillow-11.0.0[${PYTHON_USEDEP}]
	' python3_8)
	$(python_gen_cond_dep '
		>=dev-python/pillow-8.0.0[${PYTHON_USEDEP}]
	' python3_{9..13} pypy3)
	>=dev-python/pydantic-2.0.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/numpy-1.17[${PYTHON_USEDEP}]
		<dev-python/numpy-1.25[${PYTHON_USEDEP}]
	' python3_8)
	$(python_gen_cond_dep '
		<dev-python/numpy-2.1[${PYTHON_USEDEP}]
	' python3_9)
	$(python_gen_cond_dep '
		<dev-python/numpy-3.0[${PYTHON_USEDEP}]
	' python3_{10..13} pypy3)
	language-server? (
		>=dev-python/pygls-1.0.0[${PYTHON_USEDEP}]
		<dev-python/pygls-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/lsprotocol-2023[${PYTHON_USEDEP}]
		<dev-python/lsprotocol-2024[${PYTHON_USEDEP}]
	)
	svg? ( >=dev-python/drawsvg-2.0.0[${PYTHON_USEDEP}] <dev-python/drawsvg-3.0.0[${PYTHON_USEDEP}] )
	pygments? ( >=dev-python/pygments-2.10.0[${PYTHON_USEDEP}] <dev-python/pygments-3.0.0[${PYTHON_USEDEP}] )
	shapely? ( >=dev-python/shapely-2.0.0[${PYTHON_USEDEP}] <dev-python/shapely-3.0.0[${PYTHON_USEDEP}] )
	image-analysis? (
		>=dev-python/opencv-python-4.12.0.88[${PYTHON_USEDEP}]
		>=dev-python/reportlab-4.2.5[${PYTHON_USEDEP},pycairo]
		>=dev-python/svglib-1.5.1[${PYTHON_USEDEP}]
		$(python_gen_cond_dep '
			>=dev-python/scikit-image-0.20.0[${PYTHON_USEDEP}]
			<dev-python/scikit-image-0.22.0[${PYTHON_USEDEP}]
			>=dev-python/scipy-1.10.0[${PYTHON_USEDEP}]
			<dev-python/scipy-1.11.0[${PYTHON_USEDEP}]
			>=dev-python/pycairo-1.25.0[${PYTHON_USEDEP}]
			<dev-python/pycairo-1.27.0[${PYTHON_USEDEP}]
		' python3_8)
		$(python_gen_cond_dep '
			>=dev-python/scikit-image-0.22.0[${PYTHON_USEDEP}]
			<dev-python/scikit-image-1.0.0[${PYTHON_USEDEP}]
			>=dev-python/scipy-1.11.0[${PYTHON_USEDEP}]
			<dev-python/scipy-2.0.0[${PYTHON_USEDEP}]
			>=dev-python/pycairo-1.26.0[${PYTHON_USEDEP}]
			<dev-python/pycairo-2.0.0[${PYTHON_USEDEP}]
		' python3_{9..12})
		$(python_gen_cond_dep '
			>=dev-python/scikit-image-0.25.0_rc1[${PYTHON_USEDEP}]
			<dev-python/scikit-image-1.0.0[${PYTHON_USEDEP}]
			>=dev-python/scipy-1.14.1[${PYTHON_USEDEP}]
			<dev-python/scipy-2.0.0[${PYTHON_USEDEP}]
			>=dev-python/pycairo-1.27.0[${PYTHON_USEDEP}]
			<dev-python/pycairo-2.0.0[${PYTHON_USEDEP}]
		' python3_13)
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	doc? (
		>=dev-python/mkdocs-1.5.2[${PYTHON_USEDEP}]
		>=dev-python/mkdocs-material-9.6.5[${PYTHON_USEDEP}]
		>=dev-python/mkdocstrings-0.25.1[${PYTHON_USEDEP},python]
		<dev-python/mkdocstrings-0.27[${PYTHON_USEDEP}]
		>=dev-python/mkdocs-literate-nav-0.6.0[${PYTHON_USEDEP}]
		>=dev-python/mkdocs-macros-plugin-1.0.2[${PYTHON_USEDEP}]
		>=dev-python/mkdocs-gen-files-0.5.0[${PYTHON_USEDEP}]
		>=dev-python/pygments-2.15.1[${PYTHON_USEDEP}]
		>=dev-python/pymdown-extensions-10.3[${PYTHON_USEDEP}]
		>=dev-python/mike-1.1.2[${PYTHON_USEDEP}]
		<dev-python/mike-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/black-24.4.0[${PYTHON_USEDEP}]
	)
	style? (
		>=dev-python/ruff-0.11.4[${PYTHON_USEDEP}]
		>=dev-python/mypy-1.13.0[${PYTHON_USEDEP}]
		>=dev-python/pre-commit-3.3.3[${PYTHON_USEDEP}]
	)
	deploy? ( >=dev-python/twine-5.1[${PYTHON_USEDEP}] )
"

S="${WORKDIR}/${P/_alpha/a}"

src_prepare() {
	default
	# Fix version in pyproject.toml to match ebuild
	sed -i "s/version = \"3.0.0a4\"/version = \"${PV/_alpha/a}\"/" pyproject.toml || die
}

src_compile() {
	distutils-r1_src_compile
	if use doc; then
		einfo "Building documentation"
		poetry run mkdocs build || die "Failed to build documentation"
	fi
}

src_install() {
	distutils-r1_src_install
	if use doc; then
		einfo "Installing documentation"
		dodoc -r site
	fi
}

pkg_postinst() {
	if use language-server; then
		einfo "Language server is enabled. Run 'pygerber is-language-server-available' to verify."
		einfo "For Visual Studio Code support, install the 'argmaster.gerber-x3-x2-format-support' extension."
	fi
}
