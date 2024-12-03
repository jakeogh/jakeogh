# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Future-aware personal finance application"
HOMEPAGE="https://github.com/hsoft/moneyguru"
EGIT_REPO_URI="https://github.com/hsoft/moneyguru.git"

SLOT="0"
KEYWORDS=""
LICENSE="MIT"

DEPEND="dev-python/polib[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
