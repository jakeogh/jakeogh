# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit python-r1
inherit git-r3

DESCRIPTION="Generic Colouriser beautifies your logfiles or output of commands"
HOMEPAGE="http://kassiopeia.juls.savba.sk/~garabik/software/grc.html"
EGIT_REPO_URI="https://github.com/garabik/grc.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

src_prepare() {
	sed \
		-e 's:#! :#!:g' \
		-e 's:3$::g' \
		-i grc grcat || die
	default
}

src_install() {
	python_foreach_impl python_doscript grc grcat

	insinto /usr/share/grc
	doins \
		contrib/mrsmith/conf.* \
		colourfiles/conf.* \
		grc.bashrc \
		grc.fish \
		grc.zsh

	insinto /etc
	doins grc.conf

	dodoc README.markdown INSTALL TODO debian/changelog CREDITS Regexp.txt
	doman *.1
}

pkg_postinst() {
	elog
	elog "Shell specific configurations can be found in ${ROOT}usr/share/grc"
	elog "Be sure to symlink one to use grc globally:"
	elog
	elog "    ln -s ${ROOT}usr/share/grc.SHELL ${ROOT}etc/profile.d/grc.sh"
	elog
	elog "Replace 'SHELL' in the above command with one of: bashrc, fish, zsh."
	elog "Afterwards, use '. ${ROOT}etc/profile' to activate grc in existing"
	elog "shell sessions."
	elog
}
