# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Korean lunar-calendar to Gregorian calendar converter"
HOMEPAGE="https://github.com/usingsky/korean_lunar_calendar_py https://pypi.org/project/korean-lunar-calendar/"
EGIT_REPO_URI="https://github.com/usingsky/korean_lunar_calendar_py.git"

LICENSE="MIT"
SLOT="0"


# No runtime dependencies - pure Python package
RDEPEND=""

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
	elog "Korean Lunar Calendar provides conversion between:"
	elog "  - Korean lunar calendar (1000-01-01 to 2050-11-18)"
	elog "  - Gregorian calendar (1000-02-13 to 2050-12-31)"
	elog ""
	elog "Features:"
	elog "  - Solar to Lunar date conversion"
	elog "  - Lunar to Solar date conversion"
	elog "  - Korean GapJa (Sexagenary cycle) strings"
	elog "  - Chinese GapJa strings"
	elog "  - Intercalary month support"
	elog ""
	elog "Based on KARI (Korea Astronomy and Space Science Institute) data"
}
