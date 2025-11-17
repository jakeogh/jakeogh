# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3 distutils-r1

DESCRIPTION="ZFS autobackup is used to periodically backup ZFS filesystems to other locations"
HOMEPAGE="https://github.com/psy0rz/zfs_autobackup"
EGIT_REPO_URI="https://github.com/psy0rz/zfs_autobackup.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/colorama[${PYTHON_USEDEP}]
	sys-fs/zfs
"
DEPEND="${RDEPEND}"
