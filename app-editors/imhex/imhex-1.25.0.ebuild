# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
CMAKE_BUILD_TYPE="Release"
CMAKE_MAKEFILE_GENERATOR="emake"
PYTHON_COMPAT=( python3_{11..13} )

inherit cmake desktop llvm python-r1 toolchain-funcs xdg

DESCRIPTION="A hex editor for reverse engineers, programmers, and eyesight"
HOMEPAGE="https://github.com/WerWolv/ImHex"
SRC_URI="
	https://github.com/WerWolv/ImHex/releases/download/v${PV}/Full.Sources.tar.gz -> ${P}.tar.gz
	https://github.com/WerWolv/ImHex-Patterns/archive/refs/tags/ImHex-v${PV}.tar.gz -> ${PN}-patterns-${PV}.tar.gz
"
S="${WORKDIR}/ImHex"
S_PATTERNS="${WORKDIR}/ImHex-Patterns-ImHex-v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="
	python? ( ${PYTHON_DEPS} )
	app-forensics/yara
	>=dev-cpp/nlohmann_json-3.10.2
	dev-libs/capstone
	>=dev-libs/libfmt-8.0.0:=
	dev-libs/openssl
	dev-libs/tre
	media-libs/freetype
	media-libs/glfw
	media-libs/glm
	net-libs/libssh2
	net-libs/mbedtls
	net-misc/curl
	sys-apps/dbus
	sys-apps/file
	sys-apps/xdg-desktop-portal
	virtual/libiconv
	virtual/libintl
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-admin/chrpath
	gnome-base/librsvg
	sys-devel/llvm
"

pkg_pretend() {
	if tc-is-gcc && [[ $(gcc-major-version) -lt 12 ]]; then
		die "${PN} requires GCC 12 or newer"
	fi
}

src_prepare() {
	default
	# Due to network sandboxing, we can't do network test here.
	sed -i \
		-e 's/StoreAPI$/#StoreAPI/' \
		-e 's/TipsAPI$/#TipsAPI/' \
		-e 's/ContentAPI$/#ContentAPI/' \
		"${S}/tests/helpers/CMakeLists.txt" || die
	cmake_src_prepare
}

src_configure() {
	use python && python_setup

	local mycmakeargs=(
		-D CMAKE_SKIP_RPATH=ON \
		-D IMHEX_IGNORE_BAD_CLONE=ON \
		-D IMHEX_OFFLINE_BUILD=ON \
		-D IMHEX_STRIP_RELEASE=OFF \
		-D IMHEX_VERSION="${PV}" \
		-D PROJECT_VERSION="${PV}" \
		-D USE_SYSTEM_CAPSTONE=ON \
		-D USE_SYSTEM_CURL=ON \
		-D USE_SYSTEM_FMT=ON \
		-D USE_SYSTEM_LLVM=ON \
		-D USE_SYSTEM_NLOHMANN_JSON=ON \
		-D USE_SYSTEM_YARA=ON
	)
	if use python; then
		mycmakeargs+=( -D PYTHON_VERSION_MAJOR_MINOR="\"${EPYTHON/python/}\"" )
	fi
	cmake_src_configure
}

src_test() {
	pushd "${BUILD_DIR}" || die
	emake unit_tests
	popd || die
	cmake_src_test
}

src_install() {
	# Can't use cmake_src_install, doing it manual
	# Executable
	dobin "${BUILD_DIR}/${PN}"
	chrpath -d "${ED}/usr/bin/${PN}" || die
	# Shared lib and plugins
	dolib.so "${BUILD_DIR}"/lib/lib"${PN}"/lib"${PN}".so*
	chrpath -d "${ED}"/usr/"$(get_libdir)"/lib"${PN}".so* || die
	exeinto "/usr/$(get_libdir)/${PN}/plugins"
	for plugin in builtin; do
		doexe "${BUILD_DIR}/plugins/${plugin}.hexplug"
		chrpath -d "${ED}/usr/$(get_libdir)/${PN}/plugins/${plugin}.hexplug" || die
	done
	# Desktop and icon files
	domenu "${S}/dist/${PN}.desktop"
	newicon -s scalable "${S}/resources/icon.svg" "${PN}.svg"
	for i in 16 22 24 32 36 48 64 72 96 128 192 256 512; do
		mkdir "${T}/${i}x${i}" || die
		rsvg-convert -a -f png -w "${i}" -o "${T}/${i}x${i}/${PN}.png" "${S}/resources/icon.svg" || die
		doicon -s "${i}" "${T}/${i}x${i}/${PN}.png"
	done

	if use python; then
		installation() {
			mypythondir="${D}/$(python_get_sitedir)/${PN}"
			mkdir -p "${mypythondir}" || die
			cp -r "${S}"/resources/lib/python/lib/* "${mypythondir}" || die
			python_optimize "${mypythondir}"
		}
		python_foreach_impl installation
	fi

	# Install docs
	einstalldocs

	# Install patterns
	insinto /usr/share/imhex
	doins -r "${S_PATTERNS}"/*
}
