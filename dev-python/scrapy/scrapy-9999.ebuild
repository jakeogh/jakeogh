# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3
inherit distutils-r1


DESCRIPTION="A high-level Web Crawling and Web Scraping framework"
HOMEPAGE="https://github.com/jakeogh/scrapy"
EGIT_REPO_URI="/home/cfg/_myapps/scrapy https://github.com/jakeogh/scrapy.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


# The 'PyDispatcher>=2.0.5' distribution was not found and is required by Scrapy
# https://bugs.gentoo.org/684734
RDEPEND="${PYTHON_DEPS}
	>=dev-python/twisted-17.9.0[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/cssselect[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/parsel[${PYTHON_USEDEP}]
	>=dev-python/pydispatcher-2.0.5[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/queuelib[${PYTHON_USEDEP}]
	dev-python/service_identity[${PYTHON_USEDEP}]
	dev-python/w3lib[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	dev-python/Protego[${PYTHON_USEDEP}]
	>=dev-python/itemadapter-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/itemloaders-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/jmespath-0.9.5[${PYTHON_USEDEP}]
"


DEPEND="${RDEPEND}"

