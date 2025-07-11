# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit python-single-r1 git-r3
#inherit fdo-mime python-single-r1 git-r3
#inherit fdo-mime distutils-r1 git-r3

DESCRIPTION="A graphical tool to compare and merge text files"
HOMEPAGE="https://github.com/MightyCreak/diffuse"
EGIT_REPO_URI="/home/user/_myapps/diffuse"
EGIT_BRANCH="python3_install"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""
#REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"

RDEPEND="${DEPEND}
"
#	dev-python/pygtk[${PYTHON_USEDEP}]"

# file collision, bug #279018
DEPEND="${DEPEND}
	!sci-chemistry/tinker"

src_prepare() {
	eapply_user
	local i p

	# linguas handling wrt #406433
	if [[ -n "${LINGUAS+x}" ]] ; then
		for i in $(for p in translations/*.po ; do echo ${p%.po} ; done) ; do
			if ! has ${i##*/} ${LINGUAS} ; then
				rm "${S}"/${i}.po || die
			fi
		done
	fi

#	python_fix_shebang src/usr/bin/diffuse
}

src_install() {
	${PYTHON} install.py \
		--prefix="${EPREFIX}"/usr \
		--sysconfdir="${EPREFIX}"/etc \
		--files-only \
		--destdir="${D}" \
		|| die "Installation failed"
	#dodoc AUTHORS ChangeLog README
}

#pkg_postinst() {
#	fdo-mime_desktop_database_update
#}
#
#pkg_postrm() {
#	fdo-mime_desktop_database_update
#}
