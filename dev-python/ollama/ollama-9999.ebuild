# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..12} )
#DISTUTILS_USE_PEP517=poetry
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 git-r3

DESCRIPTION="Ollama Python library for integrating Python projects with Ollama"
HOMEPAGE="https://github.com/ollama/ollama-python"
EGIT_REPO_URI="https://github.com/ollama/ollama-python.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

# Explicitly set package name to ollama
PN="ollama"

RDEPEND="
	>=dev-python/httpx-0.27.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

pkg_postinst() {
	elog "Ensure Ollama is installed and running before using this library."
	elog "You may need to pull a model, e.g., 'ollama pull llama3.2'."
	elog "See https://ollama.com for available models."
}
