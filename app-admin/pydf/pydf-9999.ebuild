# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )

inherit python-r1
inherit git-r3

DESCRIPTION="Enhanced df with colors (terminal flashing disabled)"
HOMEPAGE="http://kassiopeia.juls.savba.sk/~garabik/software/pydf/"
EGIT_REPO_URI="/home/user/_myapps/pydf https://github.com/jakeogh/pydf.git"

LICENSE="public-domain"
SLOT="0"
KEYWORDS=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/asserttool[${PYTHON_USEDEP}]"

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
