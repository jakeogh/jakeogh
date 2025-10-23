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
    # Rename sh.py to hs.py so it installs as hs module
    mv sh.py hs.py || die "Failed to rename sh.py to hs.py"
    # Update pyproject.toml to reflect new name and include py.typed
    sed -i 's/name = "sh"/name = "hs"/' pyproject.toml || die
    sed -i 's/"sh.py"/"hs.py"/' pyproject.toml || die
    sed -i '/^include = \[/a\    { path = "py.typed" },' pyproject.toml || die
    distutils-r1_src_prepare
}

src_install() {
    distutils-r1_src_install

    # Install py.typed next to hs.py (PEP 561 requirement for single-file modules)
    python_foreach_impl python_domodule py.typed
}
