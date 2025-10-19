# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="Client software for CTIA cycloidal mass-spec"
HOMEPAGE="https://github.com/jakeogh/cycloidal_client"
EGIT_REPO_URI="/home/sysskel/myapps/cycloidal_client"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/serialtool[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/gpibtool[${PYTHON_USEDEP}]
	net-analyzer/scapy[${PYTHON_USEDEP}]
	dev-python/wxpython:*[${PYTHON_USEDEP}]
	dev-python/devicefilesystemtool[${PYTHON_USEDEP}]
	dev-python/devicelabeltool[${PYTHON_USEDEP}]
	dev-python/devicepartitiontool[${PYTHON_USEDEP}]
	dev-python/schedule[${PYTHON_USEDEP}]
	dev-python/sortedcontainers[${PYTHON_USEDEP}]
	dev-python/pymodbus[${PYTHON_USEDEP}]
	dev-python/usbtool[${PYTHON_USEDEP}]
"
#dev-python/pymeasure[${PYTHON_USEDEP}]
