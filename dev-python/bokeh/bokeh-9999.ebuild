# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Statistical and interactive HTML plots for Python"
HOMEPAGE="https://github.com/bokeh/bokeh"
EGIT_REPO_URI="https://github.com/bokeh/bokeh.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="examples test"

RDEPEND="
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	www-servers/tornado[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	net-libs/nodejs
	www-servers/tornado[${PYTHON_USEDEP}]
	test? (
		dev-python/beautifulsoup[${PYTHON_USEDEP}]
		dev-python/boto[${PYTHON_USEDEP}]
		dev-python/colorama[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/flexx[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nbformat[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/pytest-rerunfailures[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/selenium[${PYTHON_USEDEP}]
		sci-libs/scipy[${PYTHON_USEDEP}]
	)
"

python_compile() {
	esetup.py build --build-js
}

python_test() {
	cd "${BUILD_DIR}"/lib || die
	py.test -m 'not (js or examples or integration)' -vv || die
}

python_install_all() {
	if use examples; then
		insinto "/usr/share/doc/${PF}/examples/"
		doins examples/*
	fi
	distutils-r1_python_install_all
}
