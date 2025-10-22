# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3
inherit distutils-r1

DESCRIPTION="groups in0/in1 by pixel"
HOMEPAGE="https://github.com/jakeogh/iio-pixel-field-grouper"
EGIT_REPO_URI="https://github.com/jakeogh/iio-pixel-field-grouper.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-lang/zig
	dev-python/numpy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_install() {
	distutils-r1_src_install

	# Convert package name to Python module name (dash to underscore)
	local module_name="${PN//-/_}"

	# Find the CLI binary in any Python version's site-packages
	local cli_path=$(find "${ED}" -path "*/${module_name}/bin/${PN}" -print -quit)

	if [[ -n "${cli_path}" ]]; then
		# Remove ${ED} prefix to get the installed path
		local installed_path="${cli_path#${ED}}"
		# Create relative symlink from /usr/bin
		# This preserves the rpath $ORIGIN/../lib so the binary can find the .so
		dosym "../${installed_path#/usr/}" "/usr/bin/${PN}"
	else
		die "CLI binary not found"
	fi
}
