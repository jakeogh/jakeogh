# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Prevent identical bash/sh command lines from executing concurrently."
HOMEPAGE="https://github.com/jakeogh/shell-command-lock"
EGIT_REPO_URI="https://github.com/jakeogh/shell-command-lock.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="+minimal test"

#COMMON_DEPS="
#	|| (
#		app-arch/bzip2
#		app-arch/lbzip2[symlink]
#		app-arch/pbzip2[symlink] )
#	|| (
#		app-arch/gzip
#		app-arch/pigz[symlink] )
#	app-arch/p7zip
#	|| (
#		app-arch/rar
#		app-arch/unrar )
#	app-arch/unace
#	app-arch/unzip
#	app-arch/xz-utils"
#RDEPEND="!minimal? ( ${COMMON_DEPS} )"
#DEPEND="test? ( ${COMMON_DEPS} )"

src_compile() { :; }

src_install() {
	dodoc README*
	dobin ${PN}
}

#pkg_postinst() {
#	if [[ -z ${REPLACING_VERSIONS} ]]; then
#		echo
#		elog "unfoo can handle far more than just .tar*, but it requires some"
#		elog "optional packages to do so. For a list, either consult the source"
#		elog "(less /usr/bin/unfoo), or see http://obsoleet.org/code/unfoo"
#		elog "To get full support please use USE=-minimal"
#	elif [[ ${REPLACING_VERSIONS} < 1.0.7 ]]; then
#		elog "To get full support please use USE=-minimal"
#	fi
#}
