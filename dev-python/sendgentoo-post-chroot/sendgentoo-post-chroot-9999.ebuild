# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Short explination of what it does _here_"
HOMEPAGE="https://github.com/jakeogh/sendgentoo-post-chroot"
EGIT_REPO_URI="/home/cfg/_myapps/sendgentoo-post-chroot https://github.com/jakeogh/sendgentoo-post-chroot.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="svg"

REQUIRED_USE="!svg"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/mounttool[${PYTHON_USEDEP}]
	dev-python/portagetool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/devicetool[${PYTHON_USEDEP}]
	dev-python/boottool[${PYTHON_USEDEP}]
	dev-python/compile-kernel[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
