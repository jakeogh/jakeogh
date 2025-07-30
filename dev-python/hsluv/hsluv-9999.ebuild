# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Human-friendly HSL color space"
HOMEPAGE="
	https://www.hsluv.org/
	https://github.com/hsluv/hsluv-python/
	https://pypi.org/project/hsluv/
"
EGIT_REPO_URI="https://github.com/hsluv/hsluv-python.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc test"

# Pure Python package with no dependencies
RDEPEND=""

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
	)
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DOCS=( README.md )

python_test() {
	# Run the built-in test as mentioned in the README
	"${EPYTHON}" setup.py test || die "Tests failed"

	# Basic import and functionality test
	"${EPYTHON}" -c "
import hsluv
# Test basic HSLuv functionality
hex_color = hsluv.hsluv_to_hex((0, 100, 50))
print('HSLuv test hex:', hex_color)
rgb_color = hsluv.hsluv_to_rgb((0, 100, 50))
print('HSLuv test RGB:', rgb_color)
# Test reverse conversion
hsluv_color = hsluv.hex_to_hsluv(hex_color)
print('Reverse conversion:', hsluv_color)
print('HSLuv import and basic functionality test: PASSED')
" || die "Import/functionality test failed"
}


python_install_all() {
	distutils-r1_python_install_all

	if use doc; then
		local DOCS=( README.md )
		einstalldocs
	fi
}

pkg_postinst() {
	elog "HSLuv is a human-friendly HSL color space designed to be:"
	elog "  - Perceptually uniform"
	elog "  - Bounded (all HSLuv colors exist and map to valid RGB)"
	elog "  - Compatible with existing HSL workflows"
	elog ""
	elog "Main functions:"
	elog "  hsluv_to_hex(hue, saturation, lightness) -> hex string"
	elog "  hsluv_to_rgb(hue, saturation, lightness) -> (r, g, b)"
	elog "  hex_to_hsluv(hex) -> (hue, saturation, lightness)"
	elog "  rgb_to_hsluv(r, g, b) -> (hue, saturation, lightness)"
	elog ""
	elog "HSLuv also provides HPLuv (pastel variant) functions:"
	elog "  hpluv_to_hex(), hpluv_to_rgb(), hex_to_hpluv(), rgb_to_hpluv()"
	elog ""
	elog "Learn more: https://www.hsluv.org/"
	elog "This package is used by VisPy for advanced color operations."
}

# Note: Restricting tests for live ebuild may be needed if unstable
RESTRICT="!test? ( test )"
