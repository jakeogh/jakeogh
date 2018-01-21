# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 vcs-snapshot git-r3

DESCRIPTION="Experimental terminal UI for net-mail/notmuch written in Python"
HOMEPAGE="https://github.com/pazz/alot"
EGIT_REPO_URI="https://github.com/pazz/alot.git"
#EGIT_COMMIT="237499e631741dbb3837e5ef99cc66f842e8a92e" #bad
EGIT_COMMIT="eb9fcf11b77b9a6bebb835cfd9235fcc2fe56423" #good
#EGIT_COMMIT="8b93e7e4389c28c5f6cda37df837411b8bb57eaf" #good
#EGIT_COMMIT="840feadee7859257646d6d830420dc8b153725ad" #good

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	"
RDEPEND="
	>=dev-python/configobj-4.6.0[${PYTHON_USEDEP}]
	dev-python/pygpgme[${PYTHON_USEDEP}]
	dev-python/python-magic[${PYTHON_USEDEP}]
	dev-python/twisted
	>=dev-python/urwid-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/urwidtrees-1.0[${PYTHON_USEDEP}]
	net-mail/mailbase
	>=net-mail/notmuch-0.13[crypt,python]
	"

ALOT_UPDATE=""

pkg_setup() {
	if has_version "<${CATEGORY}/${PN}-0.3.2"; then
		ALOT_UPDATE="yes"
	fi
}

src_prepare() {
	find "${S}" -name '*.py' -print0 | xargs -0 -- sed \
		-e '1i# -*- coding: utf-8 -*-' -i || die

	distutils-r1_src_prepare

	local md
	for md in *.md; do
		mv "${md}" "${md%.md}"
	done
}

src_compile() {
	distutils-r1_src_compile

	if use doc; then
		pushd docs || die
		emake html
		popd || die
	fi
}

src_install() {
	distutils-r1_src_install

	dodir /usr/share/alot
	insinto /usr/share/alot
	doins -r extra

	if use doc; then
		dohtml -r docs/build/html/*
	fi
}

pkg_postinst() {
	if [[ ${ALOT_UPDATE} = yes ]]; then
		ewarn "The syntax of theme-files and custom tags-sections of the config"
		ewarn "has been changed.  You have to revise your config.  There are"
		ewarn "converter scripts in /usr/share/alot/extra to help you out with"
		ewarn "this:"
		ewarn ""
		ewarn "  * tagsections_convert.py for your ~/.config/alot/config"
		ewarn "  * theme_convert.py to update your custom theme files"
	fi
}
