# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Plot in the terminal using braille dots"
HOMEPAGE="https://github.com/jakeogh/plotille"
EGIT_REPO_URI="/home/sysskel/myapps/plotille https://github.com/jakeogh/plotille.git"
EGIT_BRANCH="pep517"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
