# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3


#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="Collection of library stubs for Python, with static types"
HOMEPAGE="https://github.com/jakeogh/typeshed"
EGIT_REPO_URI="/home/cfg/_myapps/typeshed https://github.com/jakeogh/typeshed.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"



#src_prepare() {
#	default
#	xdg_src_prepare
#}
