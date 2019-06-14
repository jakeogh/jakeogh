# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit distutils-r1
inherit git-r3

DESCRIPTION="make new python app from template"
HOMEPAGE="https://github.com/jakeogh/newapp"
EGIT_REPO_URI="/home/cfg/_myapps/newapp https://github.com/jakeogh/newapp.git"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS=""

#RDEPEND="!minimal? ( ${COMMON_DEPS} )"
DEPEND="
	dev-python/replace-text
"

#dev-util/splint
#dev-util/shellcheck
#dev-python/pylint
#app-misc/commandlock
#app-editors/neovim
#"

#src_compile() { :; }

python_install_all() {
    distutils-r1_python_install_all
}
