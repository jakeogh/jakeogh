# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 git-r3

DESCRIPTION="SqlAlchemy schema display script"
HOMEPAGE="https://bitbucket.org/estin/sadisplay/wiki/Home"
#COMMIT_ID="d67d12894ebd"
EGIT_REPO_URI="https://github.com/davenquinn/sadisplay"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/sqlalchemy[${PYTHON_USEDEP}]"
DEPEND="
	test? ( ${RDEPEND} )
	"

#S="${WORKDIR}/estin-${PN}-${COMMIT_ID}"

python_test() {
	nosetests -v || die
}
