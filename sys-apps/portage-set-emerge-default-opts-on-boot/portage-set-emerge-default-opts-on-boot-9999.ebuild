# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit git-r3


#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="local.d script to generate EMERGE_DEFAULT_OPTS include file for make.conf"
HOMEPAGE="https://github.com/jakeogh/portage-set-emerge_default_opts-on-boot"
EGIT_REPO_URI="/home/sysskel/myapps/portage-set-emerge-default-opts-on-boot https://github.com/jakeogh/portage-set-emerge_default_opts-on-boot.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"



#src_prepare() {
#	default
#	xdg_src_prepare
#}

src_install() {
    dobin ${PN}
}