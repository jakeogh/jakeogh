# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="chroots into a stage3 and installs the base gentoo system"
HOMEPAGE="https://github.com/jakeogh/sendgentoo-chroot"
EGIT_REPO_URI="https://github.com/jakeogh/sendgentoo-chroot.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

