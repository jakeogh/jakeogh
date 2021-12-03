# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1
#inherit xdg

DESCRIPTION="Scientific measurement library for instruments, experiments, and live-plotting"
HOMEPAGE="https://github.com/jakeogh/pymeasure"
EGIT_REPO_URI="/home/cfg/_myapps/pymeasure https://github.com/jakeogh/pymeasure.git"
EGIT_BRANCH="remove_pytest_runner"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

BDEPEND="
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
"

RDEPEND="
	dev-python/pip[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

#src_prepare() {
#	sed -i -e "/import pip/s/^/#/" -e "/pip.__version__/,+3 s/^/#/" setup.py || die
#	distutils-r1_src_prepare
#}
