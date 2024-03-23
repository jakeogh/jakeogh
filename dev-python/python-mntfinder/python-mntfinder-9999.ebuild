# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3


DESCRIPTION="Parse /proc/mounts and find/list mountpoints (Not a wrapper of findmnt)"
HOMEPAGE="https://github.com/nukemiko/python-mntfinder"
EGIT_REPO_URI="/home/sysskel/myapps/python-mntfinder https://github.com/nukemiko/python-mntfinder.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"
