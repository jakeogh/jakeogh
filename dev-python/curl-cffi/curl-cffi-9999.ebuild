# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Python binding for curl-impersonate via cffi"
HOMEPAGE="https://github.com/yifeikong/curl_cffi"
EGIT_REPO_URI="https://github.com/yifeikong/curl_cffi.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="
	>=dev-python/cffi-1.12.0[${PYTHON_USEDEP}]
	>=dev-python/certifi-2024.0.0[${PYTHON_USEDEP}]
	net-misc/curl-impersonate
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_prepare_all() {
	# Point to system libcurl-impersonate instead of downloading
	export CURL_CFFI_USE_SYSTEM_LIBCURL=1
	export CURL_CFFI_LIBCURL_DIR="/usr/$(get_libdir)"

	# Replace build.py with our modified version
	cat > scripts/build.py <<-'EOFPYTHON' || die
	import json
	import os
	import platform
	import struct
	from pathlib import Path
	import sys
	import sysconfig

	from cffi import FFI

	# this is the upstream libcurl-impersonate version
	__version__ = "1.2.2"


	def detect_arch():
	    # Check for system libcurl-impersonate
	    use_system = os.environ.get('CURL_CFFI_USE_SYSTEM_LIBCURL', '0') == '1'

	    if use_system:
	        # Use system-installed libcurl-impersonate
	        libdir = os.environ.get('CURL_CFFI_LIBCURL_DIR', '/usr/lib64')
	        if not os.path.exists(libdir):
	            libdir = '/usr/lib'

	        return {
	            'system': platform.system(),
	            'machine': platform.uname().machine,
	            'pointer_size': struct.calcsize("P") * 8,
	            'libdir': libdir,
	            'so_name': 'libcurl-impersonate.so',
	            'so_arch': platform.uname().machine,
	            'link_type': 'dynamic',
	        }

	    with open(Path(__file__).parent.parent / "libs.json") as f:
	        archs = json.loads(f.read())

	    uname = platform.uname()
	    glibc_flavor = "gnueabihf" if uname.machine in ["armv7l", "armv6l"] else "gnu"

	    libc, _ = platform.libc_ver()
	    # https://github.com/python/cpython/issues/87414
	    libc = glibc_flavor if libc == "glibc" else "musl"
	    pointer_size = struct.calcsize("P") * 8

	    for arch in archs:
	        if (
	            arch["system"] == uname.system
	            and arch["machine"] == uname.machine
	            and arch["pointer_size"] == pointer_size
	            and ("libc" not in arch or arch.get("libc") == libc)
	        ):
	            return arch
	    raise Exception(f"Unsupported arch: {uname}")


	arch = detect_arch()
	print(f"Using {arch['libdir']} to store libcurl-impersonate")


	def download_libcurl():
	    # Skip download when using system libraries
	    use_system = os.environ.get('CURL_CFFI_USE_SYSTEM_LIBCURL', '0') == '1'
	    if use_system:
	        print("Using system libcurl-impersonate")
	        return

	    if (Path(arch["libdir"]) / arch["so_name"]).exists():
	        print(".so files already present.")
	        return


	def get_curl_archives():
	    print("Files for linking")
	    print(os.listdir(arch["libdir"]))
	    # Always use dynamic linking with system libraries
	    return []


	def get_curl_libraries():
	    # Always use dynamic linking for system libraries
	    if arch["system"] == "Windows":
	        return [
	            "Crypt32",
	            "Secur32",
	            "wldap32",
	            "Normaliz",
	            "libcurl",
	            "zstd",
	            "zlib",
	            "ssl",
	            "nghttp2",
	            "nghttp3",
	            "ngtcp2",
	            "ngtcp2_crypto_boringssl",
	            "crypto",
	            "brotlienc",
	            "brotlidec",
	            "brotlicommon",
	            "iphlpapi",
	            "cares",
	        ]
	    elif arch["system"] in ("Darwin", "Linux"):
	        return ["curl-impersonate-chrome"]
	    else:
	        return []


	ffibuilder = FFI()
	system = platform.system()
	root_dir = Path(__file__).parent.parent
	download_libcurl()


	ffibuilder.set_source(
	    "curl_cffi._wrapper",
	    """
	        #include "shim.h"
	    """,
	    # FIXME from \`curl-impersonate\`
	    libraries=get_curl_libraries(),
	    extra_objects=get_curl_archives(),
	    library_dirs=[arch["libdir"]],
	    source_extension=".c",
	    include_dirs=[
	        str(root_dir / "include"),
	        str(root_dir / "ffi"),
	    ],
	    sources=[
	        str(root_dir / "ffi/shim.c"),
	    ],
	    extra_compile_args=(
	        ["-Wno-implicit-function-declaration"]
	    ),
	    extra_link_args=(["-lstdc++"] if system != "Windows" else []),
	)

	with open(root_dir / "ffi/cdef.c") as f:
	    cdef_content = f.read()
	    ffibuilder.cdef(cdef_content)


	if __name__ == "__main__":
	    ffibuilder.compile(verbose=False)
	EOFPYTHON

	distutils-r1_python_prepare_all
}

python_compile() {
	# Use system libcurl-impersonate
	export CURL_CFFI_USE_SYSTEM_LIBCURL=1
	export CURL_CFFI_LIBCURL_DIR="/usr/$(get_libdir)"

	distutils-r1_python_compile
}


python_test() {
	# Skip tests that require network access
	epytest -m "not online" || die "Tests failed with ${EPYTHON}"
}
