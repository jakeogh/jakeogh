# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="Development workflow integration"
HOMEPAGE="https://github.com/jakeogh/edittool"
EGIT_REPO_URI="https://github.com/jakeogh/edittool.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-default-group[${PYTHON_USEDEP}]
	dev-python/licenseguesser[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/asserttool[${PYTHON_USEDEP}]
	dev-python/pathtool[${PYTHON_USEDEP}]
	dev-python/configtool[${PYTHON_USEDEP}]
	dev-python/hashtool[${PYTHON_USEDEP}]
	dev-python/rope[${PYTHON_USEDEP}]
	dev-python/types-requests[${PYTHON_USEDEP}]
	dev-python/black[${PYTHON_USEDEP}]
	dev-python/byte-vector-replacer[${PYTHON_USEDEP}]
	dev-python/gittool[${PYTHON_USEDEP}]
	app-misc/colorpipe
	dev-util/pkgcheck[${PYTHON_USEDEP}]
	dev-util/pkgdev[${PYTHON_USEDEP}]
	dev-python/portagetool[${PYTHON_USEDEP}]
	dev-python/isort[${PYTHON_USEDEP}]
	dev-python/flake8[${PYTHON_USEDEP}]
	dev-python/pylint[${PYTHON_USEDEP}]
	dev-python/mypy[${PYTHON_USEDEP}]
	dev-python/beartype[${PYTHON_USEDEP}]
	dev-python/pudb[${PYTHON_USEDEP}]
	dev-util/splint
	sys-apps/yarn
"
# sys-apps/yarn pulls in nodejs for CoC



DEPEND="${RDEPEND}"
