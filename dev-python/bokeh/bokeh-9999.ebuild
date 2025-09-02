# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13,14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 git-r3

DESCRIPTION="Statistical and interactive HTML plots for Python"
HOMEPAGE="https://bokeh.org/"
EGIT_REPO_URI="https://github.com/bokeh/bokeh.git"
EGIT_BRANCH="main"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

# Runtime dependencies
RDEPEND="
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tornado[${PYTHON_USEDEP}]
"

# Build and test dependencies
DEPEND="
	${RDEPEND}
	net-libs/nodejs
	test? (
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/boto[${PYTHON_USEDEP}]
		dev-python/colorama[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/pytest-rerunfailures[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/selenium[${PYTHON_USEDEP}]
		sci-libs/scipy[${PYTHON_USEDEP}]
	)
"

# Prevent npm from failing due to sandbox/tmp issues
src_prepare() {
	default

	# Set npm config to avoid sandbox issues
	echo 'cache = ${BUILD_DIR}/npm-cache' > .npmrc
	echo 'tmp = ${BUILD_DIR}/npm-tmp' >> .npmrc
}

src_configure() {
	# Ensure node is in PATH
	if ! has_version net-libs/nodejs; then
		eerror "nodejs is required to build bokeh"
		die "nodejs not installed"
	fi
}

src_compile() {
	# 1. Build BokehJS first
	cd "${S}" || die
	LC_ALL=C npm install || die "npm install failed"
	LC_ALL=C npm run build || die "npm run build failed"

	# 2. Now let PEP 517 build the wheel
	distutils-r1_src_compile
}

python_test() {
	if use test; then
		cd "${BUILD_DIR}/lib" || die
		py.test -m 'not (js or examples or integration)' -vv || die "tests failed"
	fi
}

python_install_all() {
	use examples && dodoc -r examples
	distutils-r1_python_install_all
}

pkg_postinst() {
	elog "bokeh successfully installed!"
	elog "Try it: python -c 'import bokeh; bokeh.sampledata.download(); from bokeh.plotting import figure, show; p = figure(title=\"Simple line example\"); p.line([1, 2, 3, 4, 5], [6, 7, 2, 4, 5]); show(p)'"
	elog "Documentation: https://docs.bokeh.org"
	if use test; then
		elog "Test dependencies installed"
	fi
}

