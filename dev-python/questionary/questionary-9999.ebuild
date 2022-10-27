# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9..11} )

DISTUTILS_USE_PEP517="poetry"
inherit git-r3
inherit distutils-r1


DESCRIPTION="Python library to build pretty command line user prompts"
HOMEPAGE="https://github.com/jakeogh/questionary"
EGIT_REPO_URI="/home/cfg/_myapps/questionary https://github.com/jakeogh/questionary.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
