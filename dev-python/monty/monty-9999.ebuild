# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="Supplementary useful functions for Python that are not part of the standard library."
HOMEPAGE="https://github.com/materialsvirtuallab/monty"
EGIT_REPO_URI="https://github.com/materialsvirtuallab/monty.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/six
		dev-python/ruamel-yaml"

RDEPEND="${DEPEND}"

python_prepare_all() {
	rm -r ${WORKDIR}/monty-9999/tests/
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}
