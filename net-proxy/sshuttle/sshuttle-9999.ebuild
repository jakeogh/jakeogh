# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )

inherit linux-info distutils-r1 git-r3

DESCRIPTION="Transparent proxy server that works as a poor man's VPN using ssh"
HOMEPAGE="https://github.com/sshuttle/sshuttle https://pypi.org/project/sshuttle/"
EGIT_REPO_URI="https://github.com/sshuttle/sshuttle.git"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS=""
IUSE="doc test"

RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	|| ( net-firewall/iptables net-firewall/nftables )
"
DEPEND="
	doc? ( dev-python/sphinx )
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
	)
"

CONFIG_CHECK="~NETFILTER_XT_TARGET_HL ~IP_NF_TARGET_REDIRECT ~IP_NF_MATCH_TTL ~NF_NAT"

python_prepare_all() {
	# don't run tests via setup.py pytest
	sed -i "/setup_requires=/s/'pytest-runner'//" setup.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	emake -j1 -C $(use_enable doc docs) $(use_enable doc html) $(use_enable doc man)
}

python_test() {
	py.test -v || die "Tests fail under ${EPYTHON}"
}

python_install_all() {
	if use doc; then
		HTML_DOCS=( docs/_build/html/. )
		doman docs/_build/man/*
	fi
	distutils-r1_python_install_all
}
