# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3


#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="A python CAD programming library"
HOMEPAGE="https://github.com/jakeogh/build123d"
EGIT_REPO_URI="/home/cfg/_myapps/build123d https://github.com/jakeogh/build123d.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"



#src_prepare() {
#	default
#	xdg_src_prepare
#}
