# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# https://github.com/nE0sIghT/vortex-overlay/blob/master/dev-util/lineageos-devel-meta/lineageos-devel-meta-14.1-r1.ebuild
DESCRIPTION="Meta package providing LineageOS build environment"
HOMEPAGE="https://lineageos.org"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	app-arch/lz4
	app-arch/lzop
	=dev-util/aosp-devel-meta-7-r1
	media-gfx/imagemagick
	media-gfx/pngcrush
"
