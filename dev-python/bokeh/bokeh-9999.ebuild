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

# Test dependencies
DEPEND="
	${RDEPEND}
	net-libs/nodejs
	test? (
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/boto[${PYTHON_USEDEP}]
		
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

