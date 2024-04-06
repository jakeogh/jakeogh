# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3


DESCRIPTION="A python CAD programming library"
HOMEPAGE="https://github.com/gumyr/build123d"
EGIT_REPO_URI="/home/sysskel/myapps/build123d https://github.com/jakeogh/build123d.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""



#src_prepare() {
#	default
#	xdg_src_prepare
#}
