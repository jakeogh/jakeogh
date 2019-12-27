# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{6,7,8} pypy3 )

inherit distutils-r1
inherit git-r3

MY_PN="redis"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python client for Redis key-value store"
HOMEPAGE="https://github.com/andymccurdy/redis-py"
EGIT_REPO_URI="https://github.com/andymccurdy/redis-py"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-db/redis
		dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}"/${PN}-2.10.5-test-finalize.patch
)

python_prepare_all() {
	distutils-r1_python_prepare_all

	# Make sure that tests will be used from BUILD_DIR rather than cwd.
	mv tests tests-hidden || die

	# Correct local import patch syntax
	sed -e 's:from .conftest:from conftest:' \
		-i tests-hidden/{test_connection_pool.py,test_commands.py,test_encoding.py,test_pubsub.py} \
		|| die
}

python_compile() {
	distutils-r1_python_compile

	if use test; then
		cp -r tests-hidden "${BUILD_DIR}"/tests || die
	fi
}

python_test() {
	local sock="${T}/redis.sock"

	"${EPREFIX}/usr/sbin/redis-server" - <<- EOF
		daemonize yes
		pidfile "${T}/redis.pid"
		unixsocket ${sock}
		EOF

	PYTHONPATH="${S}:${S}/tests-hidden"
	esetup.py test --verbose
	kill $(<"${T}/redis.pid")
}
