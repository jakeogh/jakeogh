# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-r1
inherit git-r3

DESCRIPTION="Enhanced df with colors (terminal flashing disabled)"
HOMEPAGE="http://kassiopeia.juls.savba.sk/~garabik/software/pydf/"
EGIT_REPO_URI="https://github.com/jakeogh/pydf.git"

LICENSE="public-domain"
SLOT="0"
KEYWORDS=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed -i -e "s:/etc/pydfrc:${EPREFIX}/etc/pydfrc:" "${PN}" || die
}

src_install() {
	python_foreach_impl python_doscript "${PN}"
	insinto /etc
	doins "${PN}rc"
	doman "${PN}.1"
	einstalldocs
}
