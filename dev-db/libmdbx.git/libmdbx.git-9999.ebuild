# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3


#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="One of the fastest compact embeddable key-value ACID database without WAL"
HOMEPAGE="https://github.com/jakeogh/libmdbx.git"
EGIT_REPO_URI="/home/cfg/_myapps/libmdbx.git https://github.com/jakeogh/libmdbx.git.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"



#src_prepare() {
#	default
#	xdg_src_prepare
#}
