# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Create new python app from template"
HOMEPAGE="https://github.com/jakeogh/newapp"
EGIT_REPO_URI="/home/cfg/_myapps/newapp https://github.com/jakeogh/newapp.git"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS=""


# astor: nice AST printing
RDEPEND="
	dev-python/replace-text[${PYTHON_USEDEP}]
	dev-python/fastentrypoints[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/astor[${PYTHON_USEDEP}]
	dev-python/kcl[${PYTHON_USEDEP}]
	dev-python/walkup_until_found[${PYTHON_USEDEP}]
	dev-vcs/hub
"

python_install_all() {
	distutils-r1_python_install_all
}
