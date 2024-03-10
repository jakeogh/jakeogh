# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3
inherit distutils-r1

#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="clang-format python wheel"
HOMEPAGE="https://github.com/ssciwr/clang-format-wheel"
EGIT_REPO_URI="/home/sysskel/myapps/clang-format-wheel https://github.com/ssciwr/clang-format-wheel.git"
#SRC_URI="https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.0/llvm-project-18.1.0.src.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

#src_prepare() {
#	default
#	xdg_src_prepare
#}
