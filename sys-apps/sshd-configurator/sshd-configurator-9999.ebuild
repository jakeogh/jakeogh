# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{3_4,3_5,3_6,3_7} )
inherit distutils-r1
inherit git-r3

DESCRIPTION="Manages sshd configuration prior to sshd starting."
HOMEPAGE="https://github.com/jakeogh/sshd-configurator"
EGIT_REPO_URI="/home/user/_myapps/sshd-configurator"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/netifaces
dev-python/click
"

src_install() {
	#doexe ${PN}
	newinitd "${FILESDIR}/${PN}.initd" ${PN} || die
	newconfd "${FILESDIR}/${PN}.confd" ${PN} || die
}

python_install() {
	distutils-r1_python_install"
}


pkg_postinst() {
	elog "To start ${PN} at boot do rc-update add ${PN} default"
	elog "To start ${PN} now do /etc/init.d/${PN} start"
	elog "To check your sshd_config now, run ${PN}"
}
