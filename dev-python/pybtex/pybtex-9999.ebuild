# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="BibTeX-compatible bibliography processor in Python"
HOMEPAGE="https://bitbucket.org/pybtex-devs/pybtex"
EGIT_REPO_URI="https://bitbucket.org/pybtex-devs/pybtex.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="MIT"

DEPEND="dev-python/pyyaml
		dev-python/six
		dev-python/latexcodec"

RDEPEND="${DEPEND}"

python_prepare_all() {
	rm -r "${WORKDIR}/pybtex-9999/tests"
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}
