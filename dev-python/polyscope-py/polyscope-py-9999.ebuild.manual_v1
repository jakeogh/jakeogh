# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3

DESCRIPTION="Python bindings for Polyscope"
HOMEPAGE="https://polyscope.run"
EGIT_REPO_URI="https://github.com/nmwsharp/polyscope-py.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# No RDEPEND — we’ll manage Python deps manually
# No DISTUTILS — we’re doing it raw

src_install() {
	einfo "=== Starting manual build and install ==="

	# Set Python interpreter
	local PYTHON="/usr/bin/python3"
	einfo "Using Python: ${PYTHON}"

	# Build dir
	local BUILDDIR="${WORKDIR}/${P}_build"
	mkdir -p "${BUILDDIR}"
	cd "${BUILDDIR}" || die "Failed to enter build dir"

	einfo "Configuring CMake..."
	cmake "${S}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX="/usr" \
		-DPYTHON_EXECUTABLE="${PYTHON}" \
		-DUSE_PYTHON=ON \
		|| die "cmake failed"

	einfo "Building with CMake..."
	cmake --build . --config Release || die "build failed"

	# Find the built extension
	local ext=$(find . -name "polyscope*.so" | head -n1)
	if [[ -z "${ext}" ]]; then
		die "No polyscope extension found after build"
	fi
	einfo "Found extension: ${ext}"

	# Install to site-packages
	local SITEDIR="$(${PYTHON} -c 'import site; print(site.getsitepackages()[0])')"
	einfo "Installing to Python site-packages: ${SITEDIR}"
	insinto "${SITEDIR}"
	doins "${ext}" || die "Failed to install ${ext}"

	# Create stub module
	touch "${D}/${SITEDIR}/polyscope.py"
	einfo "Created polyscope.py stub"

	einfo "=== polyscope-py installed successfully ==="
}
