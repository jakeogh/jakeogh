# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1
inherit git-r3

MY_PN="sphinxcontrib_github_alt"

DESCRIPTION="Link to GitHub issues, pull requests, commits and users from Sphinx docs"
HOMEPAGE="https://github.com/jupyter/sphinxcontrib_github_alt"
EGIT_REPO_URI="https://github.com/jupyter/sphinxcontrib_github_alt.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	dev-python/sphinx[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}/${PN}"-1.1-setup.py.patch
	"${FILESDIR}/${PN}"-1.0-init.py.patch
)

S="${WORKDIR}/${MY_PN}-${PV}"

python_prepare_all() {
	distutils-r1_python_prepare_all

	mv "${WORKDIR}/${MY_PN}-${PV}"/sphinxcontrib_github_alt.py "${WORKDIR}/${MY_PN}-${PV}/${MY_PN}/" || die
}
