# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="
	dev-python/mkdocstrings
	dev-python/mkdocstrings-python
	dev-python/mkdocs-exclude
	dev-python/mkdocs-git-revision-date-localized-plugin
	dev-python/mkdocs-material
	dev-python/mkdocs-rss-plugin
"
DOCS_INITIALIZE_GIT=1

inherit distutils-r1 optfeature docs

DESCRIPTION="Modern Text User Interface framework"
HOMEPAGE="https://github.com/Textualize/textual"
EGIT_REPO_URI="https://github.com/Textualize/textual.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/markdown-it-py-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-3.6.0[${PYTHON_USEDEP}]
	<dev-python/platformdirs-5[${PYTHON_USEDEP}]
	>=dev-python/rich-13.3.3[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/griffe[${PYTHON_USEDEP}]
		dev-python/httpx[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		=dev-python/textual-dev-1.7*[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

DOCS+=( CHANGELOG.md LICENSE README.md )

EPYTEST_XDIST=1
EPYTEST_DESELECT=(
	# Those tests ask to press keys
	tests/snapshot_tests/test_snapshots.py
	tests/test_xterm_parser.py::test_escape_sequence_resulting_in_multiple_keypresses

	# Need a package that should be optional
	tests/text_area/test_languages.py

	# Xdist fails thoses
	tests/test_focus.py::test_focus_next_and_previous
	tests/test_focus.py::test_focus_next_wrap_around
	tests/test_focus.py::test_focus_previous_wrap_around
	tests/test_focus.py::test_wrap_around_selector
	tests/test_focus.py::test_no_focus_empty_selector
	tests/test_focus.py::test_focus_next_and_previous_with_type_selector
	tests/test_focus.py::test_focus_next_and_previous_with_str_selector
	tests/test_focus.py::test_focus_next_and_previous_with_str_selector_without_self
	tests/test_focus.py::test_focus_chain
	tests/test_focus.py::test_allow_focus
	tests/test_focus.py::test_focus_next_and_previous_with_type_selector_without_self
)
distutils_enable_tests pytest
# python_test() {
# 	if [[ ${EPYTHON} == python3.13 ]]; then
# 		EPYTEST_DESELECT+=(
# 			# See https://github.com/Textualize/textual/issues/5327
# 			"tests/text_area"
# 			# Some tests just do not work under python3.13 (more than half of those in this file)
# 			tests/test_focus.py
# 		)
# 		epytest -m 'not syntax' tests
# 	else
# 		epytest tests
# 	fi
# }

python_compile_all() {
	echo "INHERIT: mkdocs-offline.yml" > "${S}/mkdocs.yml"
	grep -v "\- \"*[Bb]log" "${S}/mkdocs-nav.yml" >> "${S}/mkdocs.yml"
	if use doc; then
		DOCS+=( questions )
	fi
	docs_compile
	rm "${S}/mkdocs.yml"
}

pkg_postinst() {
	optfeature "bindings for python" dev-python/tree-sitter
}
