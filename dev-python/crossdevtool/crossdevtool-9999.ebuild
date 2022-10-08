# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="crossdev setup and workflow managment"
HOMEPAGE="https://github.com/jakeogh/crossdevtool"
EGIT_REPO_URI="/home/cfg/_myapps/crossdevtool https://github.com/jakeogh/crossdevtool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icecream[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	app-portage/repoman[${PYTHON_USEDEP}]
	sys-devel/crossdev
"

DEPEND="${RDEPEND}"
