# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3

DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="git-like did-you-mean feature in click"
HOMEPAGE="https://github.com/jakeogh/click-didyoumean"
EGIT_REPO_URI="https://github.com/jakeogh/click-didyoumean.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


#src_prepare() {
#	default
#	xdg_src_prepare
#}
