# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1 git-r3

DESCRIPTION="A content-addressable file management system for Python"
HOMEPAGE="https://github.com/dgilland/hashfs"
EGIT_REPO_URI="https://github.com/dgilland/hashfs.git"
#EGIT_REPO_URI="/home/cfg/_myapps/uhashfs"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc test dev"

DEPEND="
	test? ( dev-python/pytest-cov
			dev-python/pytest
			dev-python/tox
			dev-python/twine
			dev-python/wheel
			dev-python/virtualenv )
"

#DEPEND="dev-python/psutil
#	dev-python/requests
#	dev-python/pydot
#	dev-db/sadisplay
#	dev-python/pycallgraph
#	dev-python/redis-py
#	dev-python/sqlalchemy-utils
#	dev-python/python-magic
#	dev-python/beautifulsoup
#"

#sys-apps/file[python]
#dev-python/python-magic # file has a python flag. will that work instead?

#RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
}
