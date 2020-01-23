# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{6,7,8} pypy{,3} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="an easy whitelist-based HTML-sanitizing tool"
HOMEPAGE="https://github.com/mozilla/bleach https://pypi.org/project/bleach/"
EGIT_REPO_URI="https://github.com/mozilla/bleach.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/webencodings[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
