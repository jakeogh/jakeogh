# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# from https://ict.fit.cvut.cz/gitlab/gentoo/overlay/blob/e1e9cc15a7eb136f7757c4804561c3781bcc94f6/sci-misc/gephi/gephi-0.9.2.ebuild
inherit eutils fdo-mime git-r3

DESCRIPTION="Gephi"
HOMEPAGE="https://gephi.org/"
#SRC_URI="https://github.com/gephi/gephi/releases/download/v${PV}/gephi-${PV}-linux.tar.gz"
EGIT_REPO_URI="https://github.com/gephi/gephi.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=virtual/jdk-1.8:*"
RDEPEND="${DEPEND}"

function src_unpack {
 if [ "${A}" != "" ]; then
  unpack ${A}
 fi
}

function src_configure {
 return
}

function src_compile {
 return
}

function src_install {
        local INSTDIR="/opt/${PN}"
        dodir "${INSTDIR}"

        mv "${S}" "${D}/${INSTDIR}/${PV}" || die "Install failed!"
        cp "${FILESDIR}/gephi.png" "${D}/${TARGET_DIR}/${INSTDIR}/${PV}"

        # exec wrapper - it is important to set path to JDK, netbeans won't start otherwise
        make_wrapper "$P" "${INSTDIR}/${PV}/bin/gephi"
        sed -i 's/gephi[[:space:]]/gephi --jdkhome "$JAVA_HOME" /' "${D}/usr/bin/${P}"
        # desktop entry
        make_desktop_entry "$P" "Gephi $PV" "${INSTDIR}/${PV}/gephi.png" "Development"
}

pkg_postinst(){
        fdo-mime_desktop_database_update
        fdo-mime_mime_database_update
}

pkg_postrm() {
        fdo-mime_desktop_database_update
        fdo-mime_mime_database_update
}



#
#DESCRIPTION=""
#HOMEPAGE=""
#SRC_URI=""
#
#LICENSE=""
#SLOT="0"
#KEYWORDS=""
#IUSE=""
#
#DEPEND=""
#RDEPEND="${DEPEND}"
#BDEPEND=""
