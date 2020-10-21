# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit autotools bash-completion-r1 git-r3

DESCRIPTION="A fast unix command line interface to WWW"
HOMEPAGE="https://gitlab.com/surfraw/Surfraw"
EGIT_REPO_URI="/home/cfg/_myapps/surfraw https://gitlab.com/surfraw/Surfraw.git"

LICENSE="public-domain"

SLOT="0"
KEYWORDS=""
RESTRICT="test"

RDEPEND="
        dev-lang/perl
"
DOCS=(
        AUTHORS ChangeLog HACKING NEWS README TODO
)
PATCHES=(
        "${FILESDIR}"/${PN}-2.3.0-completion.patch
)

src_prepare() {
        default
        eautoreconf
}

src_configure() {
        econf --with-elvidir='$(datadir)'/surfraw
}

src_install() {
        default

        newbashcomp surfraw-bash-completion ${PN}
        bashcomp_alias ${PN} sr

        docinto examples
        dodoc examples/README examples/uzbl_load_url_from_surfraw
}

