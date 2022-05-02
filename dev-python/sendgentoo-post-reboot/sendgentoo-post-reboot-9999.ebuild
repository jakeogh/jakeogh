# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="takes a minimal sendgentoo install to my setup"
HOMEPAGE="https://github.com/jakeogh/sendgentoo-post-reboot"
EGIT_REPO_URI="/home/cfg/_myapps/sendgentoo-post-reboot https://github.com/jakeogh/sendgentoo-post-reboot.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/proxytool[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
