# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Plot in the terminal using braille dots"
HOMEPAGE="https://github.com/jakeogh/plotille"
EGIT_REPO_URI="/home/cfg/_myapps/plotille https://github.com/jakeogh/plotille.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
