# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Manages sshd configuration prior to sshd starting."
HOMEPAGE="https://github.com/jakeogh/sshd-configurator"
EGIT_REPO_URI="/home/cfg/_myapps/sshd-configurator"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/netifaces[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/daemonize[${PYTHON_USEDEP}]
	net-misc/openssh
"

python_install_all() {
	distutils-r1_python_install_all
	newinitd "${FILESDIR}/${PN}.initd" ${PN} || die
	newconfd "${FILESDIR}/${PN}.confd" ${PN} || die
}

pkg_postinst() {
	elog "To start ${PN} at boot do \"rc-update add ${PN} default\""
	elog "To start ${PN} now do \"/etc/init.d/${PN} start\""
	elog "To check your sshd_config now, run ${PN}"
	elog "IMPORTANT: You must edit /etc/conf.d/${PN} before starting."
	elog "IMPORTANT: You must edit /etc/conf.d/sshd before starting."
	elog "IMPORTANT: Run \"${PN}\" for more information."
}
