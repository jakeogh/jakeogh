# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3


#inherit xdg
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="Ollama Python library"
HOMEPAGE="https://github.com/ollama/ollama-python"
EGIT_REPO_URI="https://github.com/ollama/ollama-python.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
#IUSE="test"


