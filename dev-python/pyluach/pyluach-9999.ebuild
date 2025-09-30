# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Python package for Hebrew (Jewish) calendar dates and conversions"
HOMEPAGE="https://github.com/simlist/pyluach https://pypi.org/project/pyluach/"
EGIT_REPO_URI="https://github.com/simlist/pyluach.git"

LICENSE="MIT"
SLOT="0"

# No runtime dependencies - pure Python package
RDEPEND=""

# Test dependencies
BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
python_test() {
	epytest
}

pkg_postinst() {
	elog "Pyluach provides Hebrew calendar manipulation features including:"
	elog "  - Hebrew-Gregorian date conversions"
	elog "  - Date arithmetic and comparisons"
	elog "  - Weekly Parsha readings"
	elog "  - Jewish holidays"
	elog "  - Hebrew calendar generation"
	elog ""
	elog "Documentation: https://pyluach.readthedocs.io/"
}
