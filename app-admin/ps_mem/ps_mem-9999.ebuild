# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 git-r3

DESCRIPTION="A utility to report core memory usage per program"
HOMEPAGE="https://github.com/pixelb/ps_mem"
EGIT_REPO_URI="/home/cfg/_myapps/ps_mem https://github.com/pixelb/ps_mem/.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
