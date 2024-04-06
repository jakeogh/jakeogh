# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1

#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="tool for checking the security hardening options of the Linux kernel"
HOMEPAGE="https://github.com/a13xp0p0v/kernel-hardening-checker"
EGIT_REPO_URI="/home/sysskel/myapps/kernel-hardening-checker https://github.com/a13xp0p0v/kernel-hardening-checker.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
"

DEPEND="${RDEPEND}"

