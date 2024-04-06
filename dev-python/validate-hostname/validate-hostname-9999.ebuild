# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="validates hostnames and addresses"
HOMEPAGE="https://github.com/jakeogh/validate-hostname"
EGIT_REPO_URI="/home/sysskel/myapps/validate-hostname https://github.com/jakeogh/validate-hostname.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
