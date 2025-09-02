# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13,14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 git-r3

DESCRIPTION="A Python wrapper for the GLM (OpenGL Mathematics) library"
HOMEPAGE="https://github.com/Zuzu-Typ/PyGLM"
EGIT_REPO_URI="https://github.com/Zuzu-Typ/PyGLM.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# No runtime deps beyond Python
RDEPEND=""

src_prepare() {
	# Fix Python 3.12 compatibility: rvalue macros
	local glmarray_h="${S}/PyGLM_lib/PyGLM/type_methods/glmArray.h"
	if [[ -f "${glmarray_h}" ]]; then
		sed -i 's/Py_ssize_t& nBytes = PyBytes_GET_SIZE(bytesObj)/Py_ssize_t nBytes = PyBytes_GET_SIZE(bytesObj)/' "${glmarray_h}" || die "Failed to patch glmArray.h"
		sed -i 's/PyTypeObject*& firstElementType = Py_TYPE(firstElement)/PyTypeObject* firstElementType = Py_TYPE(firstElement)/' "${glmarray_h}" || die "Failed to patch glmArray.h"
	else
		die "glmArray.h not found at ${glmarray_h}"
	fi

	# Clean metadata
	rm -rf src/pyglm.egg-info/ 2>/dev/null || true
	distutils-r1_src_prepare
}

python_prepare_all() {
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	elog "pyglm successfully installed!"
	elog "Try it: python -c 'import glm; print(glm.vec3(1, 2, 3))'"
	elog "Documentation: https://pyglm.readthedocs.io"
}

