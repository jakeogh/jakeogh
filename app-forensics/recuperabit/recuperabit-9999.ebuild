# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3


#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="A tool for forensic file system reconstruction."
HOMEPAGE="https://github.com/jakeogh/recuperabit"
EGIT_REPO_URI="/home/sysskel/myapps/recuperabit https://github.com/jakeogh/recuperabit.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"



#src_prepare() {
#	default
#	xdg_src_prepare
#}
