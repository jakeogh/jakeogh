# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1
inherit git-r3

DESCRIPTION="Another XRandR GUI"
HOMEPAGE="https://christian.amsuess.com/tools/arandr/"
EGIT_REPO_URI="https://gitlab.com/arandr/arandr.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/pygobject:3=[${PYTHON_USEDEP}]
	x11-apps/xrandr
"
DEPEND="
	>=dev-python/docutils-0.6[${PYTHON_USEDEP}]
"

src_prepare() {
	local i p
	# simulate gettext behavior:
	#  LINGUAS unset => install all
	#  LINGUAS="" => install none
	#  LINGUAS="de fr" => install de and fr
	if [[ -n "${LINGUAS+x}" ]] ; then # if LINGUAS is set
		for i in $(cd "${S}"/data/po ; for p in *.po ; do echo ${p%.po} ; done) ; do # for every supported language
			if ! has ${i} ${LINGUAS} ; then # if language is disabled
				rm data/po/${i}.po || die
			fi
		done
	fi

	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install
	gunzip "${D}"/usr/share/man/man1/{${PN},unxrandr}.1.gz || die
}
