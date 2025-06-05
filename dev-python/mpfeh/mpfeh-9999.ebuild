# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3
inherit distutils-r1


DESCRIPTION="messagepack stdin/stdout wrapper for feh"
HOMEPAGE="https://github.com/jakeogh/mpfeh"
EGIT_REPO_URI="https://github.com/jakeogh/mpfeh.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

