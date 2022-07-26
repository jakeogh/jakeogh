# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3


#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="View and edit files in hexadecimal or in ASCII"
HOMEPAGE="https://github.com/jakeogh/hexedit"
EGIT_REPO_URI="/home/cfg/_myapps/hexedit https://github.com/jakeogh/hexedit.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"



#src_prepare() {
#	default
#	xdg_src_prepare
#}
