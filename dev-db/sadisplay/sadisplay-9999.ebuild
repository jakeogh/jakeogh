# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{7,8} )

inherit distutils-r1 mercurial

DESCRIPTION="SqlAlchemy schema display script"
HOMEPAGE="https://bitbucket.org/estin/sadisplay/wiki/Home"
#COMMIT_ID="d67d12894ebd"
EHG_REPO_URI="https://bitbucket.org/estin/sadisplay"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/sqlalchemy[${PYTHON_USEDEP}]"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND} )
	"
S="${WORKDIR}/estin-${PN}-${COMMIT_ID}"

python_test() {
	nosetests -v || die
}
