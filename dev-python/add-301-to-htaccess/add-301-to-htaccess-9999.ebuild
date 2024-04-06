# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="add 301 redirect to .htaccess on remote ssh host"
HOMEPAGE="https://github.com/jakeogh/add-301-to-htaccess"
EGIT_REPO_URI="/home/sysskel/myapps/add-301-to-htaccess https://github.com/jakeogh/add-301-to-htaccess.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/with-chdir[${PYTHON_USEDEP}]
	dev-python/with-sshfs[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
