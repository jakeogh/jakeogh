# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517="poetry"
inherit git-r3
inherit distutils-r1
DESCRIPTION="Python3.8+ process launching (hs fork with mutating bake)"
HOMEPAGE="https://github.com/jakeogh/sh"
EGIT_REPO_URI="https://github.com/jakeogh/sh.git"
EGIT_BRANCH="hs"
LICENSE="BSD"
SLOT="0"
KEYWORDS=""
RDEPEND="
    !dev-python/sh:0/hs
"
DEPEND="${RDEPEND}"
src_prepare() {
    mkdir -p hs || die
    mv hs.py hs/__init__.py || die
    cp py.typed hs/ || die
    distutils-r1_src_prepare
}
src_install() {
    distutils-r1_src_install
}



## Copyright 1999-2022 Gentoo Authors
## Distributed under the terms of the GNU General Public License v2
#EAPI=8
#PYTHON_COMPAT=( python3_{12..14} )
#DISTUTILS_USE_PEP517="poetry"
#inherit git-r3
#inherit distutils-r1
#
#DESCRIPTION="Python3.8+ process launching (hs fork with mutating bake)"
#HOMEPAGE="https://github.com/jakeogh/sh"
#EGIT_REPO_URI="https://github.com/jakeogh/sh.git"
#EGIT_BRANCH="hs"
#
#LICENSE="BSD"
#SLOT="0"
#KEYWORDS=""
#
#RDEPEND="
#    !dev-python/sh:0/hs
#"
#DEPEND="${RDEPEND}"
#
#src_prepare() {
#    # Convert to a package structure for proper PEP 561 support
#    mkdir -p hs || die
#    mv sh.py hs/__init__.py || die
#    cp py.typed hs/ || die
#
#    # Update pyproject.toml
#    sed -i 's/name = "sh"/name = "hs"/' pyproject.toml || die
#    sed -i 's/"sh.py"/"hs\/__init__.py", "hs\/py.typed"/' pyproject.toml || die
#
#    distutils-r1_src_prepare
#}
#
#src_install() {
#    distutils-r1_src_install
#}
