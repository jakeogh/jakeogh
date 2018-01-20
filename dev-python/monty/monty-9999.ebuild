# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="This repository implements supplementary useful functions for Python that are not part of the standard library. Examples include useful utilities like transparent support for zipped files etc."
HOMEPAGE="https://github.com/materialsvirtuallab/monty"
EGIT_REPO_URI="https://github.com/materialsvirtuallab/monty.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/six
		dev-python/ruamel-yaml"

RDEPEND="${DEPEND}"

python_install_all() {
        distutils-r1_python_install_all
}


#        local DOCS=( README.md )
