# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8


PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1
inherit git-r3
PYTHON_REQ_USE="ssl(+),threads(+)"
# https://bugs.gentoo.org/879011
DESCRIPTION="Coroutine-based network library"
HOMEPAGE="https://www.gevent.org/ https://pypi.org/project/gevent"
IUSE="monitor recommended test"
EGIT_REPO_URI="https://github.com/gevent/gevent"



DEPENDENCIES=">=dev-python/greenlet-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/greenlet-3.0[${PYTHON_USEDEP}]
	dev-python/zope-event[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	monitor? ( >=dev-python/psutil-5.7.0[${PYTHON_USEDEP}] )
	recommended? ( >=dev-python/cffi-1.12.2[${PYTHON_USEDEP}] )
	recommended? ( >=dev-python/psutil-5.7.0[${PYTHON_USEDEP}] )
	"
BDEPEND="${DEPENDENCIES}"
RDEPEND="${DEPENDENCIES}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos"
RESTRICT="!test? ( test )"


#distutils_enable_sphinx doc
#
#python_prepare_all() {
#	export GEVENTSETUP_EMBED="false"
#
#	distutils-r1_python_prepare_all
#}
#
#python_test() {
#	# Just in case.
#	export GEVENTTEST_USE_RESOURCES=-network
#
#	cd src/gevent/tests || die
#
#	# Tests which need network but aren't marked as such
#	echo "test__getaddrinfo_import.py" >> tests_that_dont_use_resolver.txt || die
#	echo "test_socketqcqqrwns.py" >> tests_that_dont_use_resolver.txt || die
#
#	# Test hangs (testPeek)
#	echo "test_socket.py" >> tests_that_dont_use_resolver.txt || die
#
#	# TODO: figure out how to make them work and not hang
#	#GEVENT_RESOLVER=ares \
#	#       "${EPYTHON}" -m gevent.tests \
#	#       --verbose \
#	#       -uall,-network \
#	#       --config known_failures.py \
#	#       --ignore tests_that_dont_use_resolver.txt || die
#	GEVENT_RESOLVER=dnspython \
#		"${EPYTHON}" -m gevent.tests \
#		--verbose \
#		-uall,-network \
#		--config known_failures.py \
#		--ignore tests_that_dont_use_resolver.txt || die
#	GEVENT_RESOLVER=thread \
#		"${EPYTHON}" -m gevent.tests \
#		--verbose \
#		-uall,-network \
#		--config known_failures.py \
#		--ignore tests_that_dont_use_resolver.txt || die
#	GEVENT_FILE=thread \
#		"${EPYTHON}" -m gevent.tests \
#		--verbose \
#		-uall,-network \
#		--config known_failures.py \
#		test__*subprocess*.py || die
#}
#
#python_install_all() {
#	local DOCS=( AUTHORS README.rst )
#	use examples && dodoc -r examples
#
#	distutils-r1_python_install_all
#}
