# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Diff JSON and JSON-like structures in Python."
HOMEPAGE="https://github.com/ZoomerAnalytics/jsondiff"
EGIT_REPO_URI="https://github.com/ZoomerAnalytics/jsondiff.git"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
