# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1
inherit git-r3

DESCRIPTION="Kernel modules for GPIB (IEEE 488.2) hardware"
HOMEPAGE="https://linux-gpib.sourceforge.io/"
#SRC_URI="https://downloads.sourceforge.net/linux-gpib/linux-gpib-${PV}.tar.gz"
EGIT_REPO_URI="https://git.code.sf.net/p/linux-gpib/git"
S="${WORKDIR}/linux-gpib-kernel-${PV}"
EGIT_CHECKOUT_DIR="${S}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~x86"
IUSE="debug"

COMMONDEPEND=""
RDEPEND="${COMMONDEPEND}
	acct-group/gpib
"
DEPEND="${COMMONDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	# don't fix debian bugs if they break gentoo
	#"${FILESDIR}/${PN}-4.3.4-depmod.patch"
	# https://sourceforge.net/p/linux-gpib/code/2053/
	"${FILESDIR}/${PN}-4.3.4-kernel-6.4.patch"
)

MODULES_KERNEL_MIN=2.6.8

src_configure() {
	pwd
	echo "${FILESDIR}"
	MODULES_MAKEARGS+=(LINUX_SRCDIR="${KV_OUT_DIR}")
	use debug && MODULES_MAKEARGS+=('GPIB-DEBUG=1')
}

src_compile() {
	# The individual modules don't have separate targets so we can't use
	# modlist here.
	emake "${MODULES_MAKEARGS[@]}"
}

src_install() {
	emake \
		"${MODULES_MAKEARGS[@]}" \
		DESTDIR="${ED}" \
		INSTALL_MOD_PATH="${ED}" \
		docdir="${ED}/usr/share/doc/${PF}/html" \
		install

	modules_post_process

	dodoc ChangeLog AUTHORS README* NEWS
	einstalldocs
}
