# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# from https://raw.githubusercontent.com/Miezhiko/Overlay/refs/heads/mawa/dev-python/toml/toml-0.10.2-r1.ebuild
EAPI=8


DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

TOML_TEST_VER="280497fa5f12e43d7233aed0d74e07ca61ef176b"

DESCRIPTION="Python library for handling TOML files"
HOMEPAGE="
	https://github.com/uiri/toml/
	https://pypi.org/project/toml/
"
SRC_URI="
	https://github.com/uiri/${PN}/archive/${PV}.tar.gz -> ${P}-1.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~x64-macos ~x64-solaris"

BDEPEND=""

DOCS=( README.rst )

distutils_enable_tests pytest

python_prepare_all() {
	distutils-r1_python_prepare_all
}
