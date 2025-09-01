# Copyright 2025
# Distributed under the terms of the BSD-2-Clause license

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

# Tell distutils-r1 the PEP 517 backend *before* inheriting it.
DISTUTILS_USE_PEP517=hatchling

inherit git-r3 distutils-r1

DESCRIPTION="WebGPU for Python (pygfx/wgpu-py)"
HOMEPAGE="https://wgpu-py.readthedocs.io https://github.com/pygfx/wgpu-py"
LICENSE="BSD-2"
SLOT="0"
IUSE="glfw jupyter"

# Live ebuild
EGIT_REPO_URI="https://github.com/pygfx/wgpu-py.git"

# Keep builds network-free; tests disabled by default (GPU required)
RESTRICT="test"

# Build-time deps (PEP 517 backend is hatchling; requests was referenced by
# the upstream hatch hook we strip out, but keeping it is harmless)
BDEPEND="
	${PYTHON_DEPS}
	>=dev-python/hatchling-1[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

# Runtime deps from pyproject [project.dependencies]
RDEPEND="
	${PYTHON_DEPS}
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
	glfw? ( dev-python/glfw[${PYTHON_USEDEP}] )
	jupyter? ( dev-python/jupyter-rfb[${PYTHON_USEDEP}] )
"

src_prepare() {
	eapply_user

	# Upstream hatch build hook bundles prebuilt wgpu-native (downloads).
	# Strip the hook section to keep Gentoo builds network-free.
	if [[ -f pyproject.toml ]]; then
		# Remove the whole hooks.custom section
		awk '
			BEGIN{skip=0}
			/^\[tool\.hatch\.build\.targets\.wheel\.hooks\.custom\]/ {skip=1; next}
			/^\[/ { if (skip) skip=0 }
			{ if (!skip) print }
		' pyproject.toml > pyproject.toml.new || die
		mv pyproject.toml.new pyproject.toml || die

		# Drop any artifacts lines that try to include *.so, *.dll, *.dylib
		sed -i -e '/^\s*artifacts\s*=.*\.\(so\|dll\|dylib\)/d' pyproject.toml || die
	fi

	distutils-r1_src_prepare
}

python_configure_all() {
	# Defensive: ensure no residual download/bundling attempts
	export WGPUPY_NO_FETCH=1
	export WGPU_SKIP_DOWNLOAD=1
}

python_test() {
	: # tests require a working GPU context; disabled via RESTRICT
}

pkg_postinst() {
	elog "Installed wgpu as a pure-Python package (no bundled wgpu-native)."
	elog "Provide a system WebGPU native lib and point wgpu at it, e.g.:"
	elog "  export WGPU_LIB_PATH=/usr/$(get_libdir)/libwgpu_native.so"
	use glfw && elog "USE=glfw enabled: GLFW backend available."
	use jupyter && elog "USE=jupyter enabled: Jupyter widgets available."
}

