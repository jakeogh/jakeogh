# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1

#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="flask html table generator"
HOMEPAGE="https://github.com/jakeogh/flask-table"
EGIT_REPO_URI="/home/sysskel/myapps/flask-table https://github.com/jakeogh/flask-table.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/flask-babel[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

