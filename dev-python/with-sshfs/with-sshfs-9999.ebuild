# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Context manager for sshfs mount"
HOMEPAGE="https://github.com/jakeogh/with-sshfs"
EGIT_REPO_URI="/home/cfg/_myapps/with-sshfs https://github.com/jakeogh/with-sshfs.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	net-fs/sshfs
"

DEPEND="${RDEPEND}"


