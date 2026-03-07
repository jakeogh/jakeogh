# Copyright 2026 Gentoo Authors
# Distributed under the terms of the CDDL-1.0 License

EAPI=8
PYTHON_COMPAT=( python3_{11,12,13} )
DISTUTILS_USE_PEP517=flit

inherit distutils-r1 linux-mod-r1

DESCRIPTION="Content-addressable blob store kernel module for OpenZFS"
HOMEPAGE="https://github.com/example/zblob"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/example/zblob.git"
else
	SRC_URI="https://github.com/example/zblob/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="CDDL-1.0"
SLOT="0"
IUSE="benchmark"

# linux-mod-r1 fills in RDEPEND/DEPEND for kernel headers automatically.
# ZFS dev headers + Module.symvers are needed at build time; zfs at runtime.
DEPEND="
	sys-fs/zfs-kmod
"
RDEPEND="
	sys-fs/zfs
	${PYTHON_DEPS}
"
BDEPEND="
	${PYTHON_DEPS}
	benchmark? ( dev-python/tabulate[${PYTHON_USEDEP}] )
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# linux-mod-r1: declare the two modules we build
MODULE_NAMES=(
	"zblob_crypto(extra:${S})"
	"zblob(extra:${S})"
)
BUILD_TARGETS="modules"
BUILD_PARAMS="ZFS_SRC=\"\$(pkg-config --variable=includedir zfs 2>/dev/null || echo /usr/src/zfs-\${KV_FULL})\""

# distutils-r1 needs a pyproject.toml; we generate a minimal one because
# upstream ships zblob.py as a bare file with no packaging metadata.
python_prepare_all() {
	cat > "${S}/pyproject.toml" <<-EOF
		[build-system]
		requires = ["flit_core>=3.2"]
		build-backend = "flit_core.buildapi"

		[project]
		name = "zblob"
		version = "${PV/_p/.post}"
		description = "Python bindings for the zblob kernel module"
		license = {text = "CDDL-1.0"}
		requires-python = ">=3.11"

		[tool.flit.module]
		name = "zblob"
	EOF

	distutils-r1_python_prepare_all
}

src_compile() {
	# Build kernel module via linux-mod-r1
	linux-mod-r1_src_compile

	# Build/byte-compile Python package via distutils-r1
	distutils-r1_src_compile
}

src_install() {
	# Install kernel modules (handles depmod bookkeeping)
	linux-mod-r1_src_install

	# Install Python bindings into site-packages
	distutils-r1_src_install

	# Install udev rule so /dev/zblob is group-accessible without root
	insinto /usr/lib/udev/rules.d
	newins - 60-zblob.rules <<-EOF
		KERNEL=="zblob", MODE="0660", GROUP="zblob"
	EOF

	# Install the test scripts under /usr/share for use by optional tests
	insinto /usr/share/${PN}/tests
	doins zblob_test.py test_d1_acquire_deadlock.py test_gc_break.py

	if use benchmark; then
		doins bench_zblob.py bench_common.py
	fi
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst

	elog "Add users who need direct /dev/zblob access to the 'zblob' group:"
	elog "  usermod -aG zblob \$USER"
	elog ""
	elog "The module requires OpenZFS headers at build time.  If the build"
	elog "failed with 'Cannot find ZFS source tree', set ZFS_SRC= in"
	elog "/etc/portage/env/sys-fs/zblob or install sys-fs/zfs-kmod with"
	elog "the sources USE flag."
}
